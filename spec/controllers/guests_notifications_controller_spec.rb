# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuestsNotificationsController do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:guest) { create :guest, event: event }
  let(:other_guest) { create :guest, event: event }
  let(:experience) { create :experience, event: event }
  let(:notification) { create :notification, experience: experience }
  let(:guests_notification) do
    create :guests_notification, guest: guest, notification: notification
  end

  before { sign_in user }

  describe 'GET #new' do
    it 'assigns the event as @event' do
      get :new, params: {
        event_id: event.id,
        experience_id: experience.id,
        notification_id: notification.id
      }

      expect(assigns(:event)).to eq event
    end

    it 'assigns new experience as @experience' do
      get :new, params: {
        event_id: event.id,
        experience_id: experience.id,
        notification_id: notification.id
      }

      expect(assigns(:experience)).to eq experience
    end

    it 'assigns new notification as @notification' do
      get :new, params: {
        event_id: event.id,
        experience_id: experience.id,
        notification_id: notification.id
      }

      expect(assigns(:notification)).to eq notification
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates guests_notifications' do
        expect do
          post :create, params: {
            event_id: event.id,
            experience_id: experience.id,
            notification_id: notification.id,
            guests_notifications: {
              guest_ids: [guest.id, other_guest.id]
            }
          }
        end.to change(GuestsNotification, :count).by 2
      end
    end

    context 'with invalid params' do
      it 're-renders new' do
        post :create, params: {
          event_id: event.id,
          experience_id: experience.id,
          notification_id: notification.id,
          guests_notifications: {
            guest_ids: ['asdf']
          }
        }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the guests_notification' do
      delete :destroy, params: {
        event_id: event.id,
        experience_id: experience.id,
        notification_id: notification.id,
        id: guests_notification.id
      }
      expect(GuestsNotification.all).to_not include guests_notification
    end

    it 'renders the notification page' do
      delete :destroy, params: {
        event_id: event.id,
        experience_id: experience.id,
        notification_id: notification.id,
        id: guests_notification.id
      }
      expect(response).to redirect_to(
        event_experience_notification_path(event, experience, notification)
      )
    end
  end
end
