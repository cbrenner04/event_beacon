# frozen_string_literal: true

# notifications controller
class NotificationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @notification = Notification.new(sms_body: '', email_body: '')
  end

  def create
    @event = Event.find(params[:event_id])
    @notification = experience.build_notification(notification_params)
    if @notification.save
      Tasks::Notifier.send_to_all_now(@notification)
      redirect_to event_path(@event), notice: 'Sent successfully.'
    else
      render :new
    end
  end

  def show
    set_instance_variables
  end

  def edit
    set_instance_variables
    @sms_link = helpers.sanitize(@notification.sms_link)
  end

  def update
    set_instance_variables
    if @notification.update(notification_params)
      redirect_to(
        event_experience_notification_path(@event, @experience, @notification),
        notice: "#{@experience.name} notification was updated successfully."
      )
    else
      render :edit
    end
  end

  def preview_email; end

  private

  def notification_params
    params.require(:notification).permit(:sms_body, :email_body)
  end

  def set_instance_variables
    @experience = Experience.find(params[:experience_id])
    @event = @experience.event
    @notification = Notification.find(params[:id])
    @guests_notifications = @notification.guests_notifications
  end

  def experience
    # create experience and set it beyond the time needed for next nofitication
    ten_hours_ago = Time.zone.now - 10 * 60 * 60
    @experience ||= Experience.create!(
      name: "Send now! #{Time.zone.now}",
      occurs_at: ten_hours_ago,
      notification_offset: 60,
      event: @event
    )
  end
end
