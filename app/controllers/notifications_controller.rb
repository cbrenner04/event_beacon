# frozen_string_literal: true

# notifications controller
class NotificationsController < ApplicationController
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
end
