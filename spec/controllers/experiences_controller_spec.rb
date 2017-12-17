# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExperiencesController do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:experience) { create :experience }

  before { sign_in user }

  describe 'GET #index' do
    it 'assigns the requested event as @event' do
      get :index, params: {
        event_id: event.id
      }

      expect(assigns(:event)).to eq event
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested experience as @experience' do
      get :edit, params: {
        event_id: event.id,
        id: experience.id
      }

      expect(assigns(:experience)).to eq experience
    end
  end
end
