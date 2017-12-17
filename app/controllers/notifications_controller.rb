# frozen_string_literal: true

# notifications controller
class NotificationsController < ApplicationController
  def show
    @experience = Experience.find(params[:experience_id])
    @event = @experience.event
    @notification = Notification.find(params[:id])
    @guests = @notification.guests_notifications.map(&:guest)
  end
end
