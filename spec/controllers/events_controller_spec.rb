# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let!(:user) { create :user }
  let!(:other_user) { create :user }
  let!(:event) { create :event, name: 'foo' }
  let!(:other_event) { create :event, name: 'bar' }
  let!(:users_event) { create :users_event, user: user, event: event }
  let!(:other_users_event) do
    create :users_event, user: other_user, event: other_event
  end

  before { sign_in user }

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
end
