# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuestsNotificationsController do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:guest) { create :guest, event: event }
  let(:experience) { create :experience, event: event }
  let(:notification) { create :notification, experience: experience }
  let(:guests_notification) do
    create :guests_notification, guest: guest, notification: notification
  end

  before { sign_in user }

  describe 'DELETE #destroy' do
    it 'deletes the guests_notification' do
      delete :destroy, params: {
        id: guests_notification.id
      }
      expect(GuestsNotification.all).to_not include guests_notification
    end

    it 'renders the notification page' do
      delete :destroy, params: {
        id: guests_notification.id
      }
      expect(response).to redirect_to(
        event_experience_notification_path(event, experience, notification)
      )
    end
  end
end
