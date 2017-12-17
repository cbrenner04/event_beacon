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

  describe 'GET #edit' do
    it 'assigns the requested guest as @guest' do
      get :edit, params: {
        event_id: event.id,
        id: guest.id
      }

      expect(assigns(:guest)).to eq guest
    end
  end
end
