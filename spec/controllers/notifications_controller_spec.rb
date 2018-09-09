# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationsController do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:guest) { create :guest, event: event }
  let(:experience) { create :experience, event: event }
  let(:notification) { create :notification, experience: experience }
  let(:guests_notification) do
    create :guests_notification, guest: guest, notification: notification
  end

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns the variables' do
      get :new, params: {
        event_id: event.id
      }

      expect(assigns(:event)).to eq event
      expect(assigns(:notification)).to be_a_new(Notification)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates experience, notification and calls notifier' do
        allow(Tasks::Notifier).to receive(:send_to_all_now)
        expect do
          post :create, params: {
            event_id: event.id,
            notification: {
              sms_body: 'foo',
              email_body: 'bar'
            }
          }
        end.to change(Event, :count).by(1).and(
          change(Experience, :count).by(1)
        )
        expect(Tasks::Notifier).to have_received(:send_to_all_now)
      end
    end

    context 'with invalid params' do
      it 're-renders new' do
        post :create, params: {
          event_id: event.id,
          notification: {
            sms_body: nil
          }
        }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the related experience as @experience' do
      get :show, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:experience)).to eq experience
    end

    it 'assigns the related event as @event' do
      get :show, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:event)).to eq event
    end

    it 'assigns the requests notification as @notification' do
      get :show, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:notification)).to eq notification
    end

    it 'assigns the related guests as @guests' do
      guests_notification.save
      get :show, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:guests_notifications)).to include guests_notification
    end
  end

  describe 'GET #edit' do
    it 'assigns the related experience as @experience' do
      get :edit, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:experience)).to eq experience
    end

    it 'assigns the related event as @event' do
      get :edit, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:event)).to eq event
    end

    it 'assigns the requests notification as @notification' do
      get :edit, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:notification)).to eq notification
    end

    it 'assigns the related guests as @guests' do
      guests_notification.save
      get :edit, params: {
        event_id: event.id,
        experience_id: experience.id,
        id: notification.id
      }

      expect(assigns(:guests_notifications)).to include guests_notification
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates notification' do
        patch :update, params: {
          event_id: event.id,
          experience_id: experience.id,
          id: notification.id,
          notification: {
            sms_body: 'foobar'
          }
        }
        notification.reload
        expect(notification.sms_body).to eq 'foobar'
      end
    end

    context 'with invalid params' do
      it 're-renders edit' do
        patch :update, params: {
          event_id: event.id,
          experience_id: experience.id,
          id: notification.id,
          notification: {
            sms_body: nil
          }
        }
        expect(response).to render_template :edit
      end
    end
  end
end
