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

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates experience' do
        patch :update, params: {
          event_id: event.id,
          id: experience.id,
          experience: {
            name: 'foobaz'
          }
        }
        experience.reload
        expect(experience.name).to eq 'foobaz'
      end
    end

    context 'with invalid params' do
      it 're-renders edit' do
        patch :update, params: {
          event_id: event.id,
          id: experience.id,
          experience: {
            name: nil
          }
        }
        expect(response).to render_template :edit
      end
    end
  end
end
