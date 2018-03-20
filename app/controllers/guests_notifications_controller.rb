# frozen_string_literal: true

# guests notifications controller
class GuestsNotificationsController < ApplicationController
  def new
    set_instance_variables
    @potential_guests = @event.guests.not_related_to_notification(@notification)
  end

  def create
    set_instance_variables
    if built_notifications.all?(&:save)
      redirect_to(
        event_experience_notification_path(@event, @experience, @notification),
        notice: 'Guests were successfully added to the notification'
      )
    else
      render :new
    end
  end

  def destroy
    set_instance_variables
    @guests_notification = GuestsNotification.find(params[:id])
    @guests_notification.delete
    redirect_to(
      event_experience_notification_path(@event, @experience, @notification),
      notice: "The notification for #{@guests_notification.guest.full_name} " \
              'was deleted successfully'
    )
  end

  private

  def set_instance_variables
    @notification = Notification.find(params[:notification_id])
    @experience = Experience.find(params[:experience_id])
    @event = Event.find(params[:event_id])
  end

  def guests_notifications_params
    params.require(:guests_notifications).permit(guest_ids: [])
  end

  def built_notifications
    guests_notifications_params[:guest_ids].map do |guest_id|
      next if guest_id.blank?
      @notification.guests_notifications.build(guest_id: guest_id)
    end.compact
  end
end
