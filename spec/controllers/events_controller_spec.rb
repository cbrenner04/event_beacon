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
end
