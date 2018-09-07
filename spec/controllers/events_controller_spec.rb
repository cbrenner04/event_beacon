# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:event) { create :event, name: 'foo' }
  let(:other_event) { create :event, name: 'bar' }

  before do
    create :users_event, user: user, event: event
    create :users_event, user: other_user, event: other_event
    sign_in user
  end

  describe 'GET #index' do
    it 'returns events for current_user only' do
      get :index

      expect(assigns(:events)).to include event
      expect(assigns(:events)).to_not include other_event
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event as @event' do
      get :show, params: {
        id: event.id
      }

      expect(assigns(:event)).to eq event
    end
  end

  describe 'GET #new' do
    it 'assigns the event as @event' do
      get :new

      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates event' do
        expect do
          post :create, params: {
            event: {
              name: 'foobaz',
              occurs_at: Time.zone.now,
              organizer: 'foo'
            }
          }
        end.to change(Event, :count).by 1
      end

      it 'creates related users event' do
        expect do
          post :create, params: {
            event: {
              name: 'asdf',
              occurs_at: Time.zone.now,
              organizer: 'asdf'
            }
          }
        end.to change(UsersEvent, :count).by 1
      end
    end

    context 'with invalid params' do
      it 're-renders new' do
        post :create, params: {
          event_id: event.id,
          event: {
            name: nil
          }
        }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested event as @event' do
      get :edit, params: {
        id: event.id
      }

      expect(assigns(:event)).to eq event
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates event' do
        patch :update, params: {
          id: event.id,
          event: {
            name: 'foobaz'
          }
        }
        event.reload
        expect(event.name).to eq 'foobaz'
      end
    end

    context 'with invalid params' do
      it 're-renders edit' do
        patch :update, params: {
          id: event.id,
          event: {
            name: nil
          }
        }
        expect(response).to render_template :edit
      end
    end
  end
end
