# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuestsController do
  let(:user) { create :user }
  let(:event) { create :event }
  let!(:guest) { create :guest, event: event }

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns the requested event as @event' do
      get :index, params: {
        event_id: event.id
      }

      expect(assigns(:event)).to eq event
    end

    it 'assigns related guests as @guests' do
      get :index, params: {
        event_id: event.id
      }

      expect(assigns(:guests)).to include guest
    end
  end

  describe 'GET #new' do
    it 'assigns the event as @event' do
      get :new, params: {
        event_id: event.id
      }

      expect(assigns(:event)).to eq event
    end

    it 'assigns new guest as @guest' do
      get :new, params: {
        event_id: event.id
      }

      expect(assigns(:guest)).to be_a_new(Guest)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates guest' do
        expect do
          post :create, params: {
            event_id: event.id,
            guest: {
              first_name: 'foobaz',
              email: 'foobaz@example.com'
            }
          }
        end.to change(Guest, :count).by 1
      end
    end

    context 'with invalid params' do
      it 're-renders new' do
        post :create, params: {
          event_id: event.id,
          guest: {
            first_name: nil
          }
        }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested guest as @guest' do
      get :edit, params: {
        event_id: event.id,
        id: guest.id
      }

      expect(assigns(:guest)).to eq guest
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates guest' do
        patch :update, params: {
          event_id: event.id,
          id: guest.id,
          guest: {
            first_name: 'foobar',
            last_name: 'baz'
          }
        }
        guest.reload
        expect(guest.full_name).to eq 'foobar baz'
      end
    end

    context 'with invalid params' do
      it 're-renders edit' do
        patch :update, params: {
          event_id: event.id,
          id: guest.id,
          guest: {
            first_name: nil,
            last_name: nil
          }
        }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the guest' do
      delete :destroy, params: {
        event_id: event.id,
        id: guest.id
      }
      expect(Guest.all).to_not include guest
    end

    it 'renders the notification page' do
      delete :destroy, params: {
        event_id: event.id,
        id: guest.id
      }
      expect(response).to redirect_to event_guests_path(event)
    end
  end
end
