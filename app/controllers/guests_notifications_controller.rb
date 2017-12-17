# frozen_string_literal: true

# guests notifications controller
class GuestsNotificationsController < ApplicationController
  def destroy
    @guests_notification = GuestsNotification.find(params[:id])
    notification = @guests_notification.notification
    experience = notification.experience
    event = experience.event
    @guests_notification.delete
    redirect_to(
      event_experience_notification_path(event, experience, notification),
      notice: "The notification for #{@guests_notification.guest.full_name} " \
              'was deleted successfully'
    )
  end
end
