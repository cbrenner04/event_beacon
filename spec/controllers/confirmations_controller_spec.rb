# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfirmationsController do
  let(:user) { User.create(email: 'foobar@example.com') }

  before { @request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'GET #show' do
    it 'assigns the requested user as @resource' do
      get :show, params: {
        confirmation_token: user.confirmation_token
      }

      expect(assigns(:original_token)).to eq user.confirmation_token
      expect(assigns(:resource)).to eq user
    end
  end

  describe 'PATCH #confirm' do
    context 'with valid params' do
      it 'updates user' do
        expect(user).to_not be_confirmed
        patch :confirm, params: {
          user: {
            confirmation_token: user.confirmation_token,
            password: 'foobaz',
            password_confirmation: 'foobaz'
          }
        }
        user.reload
        expect(user).to be_confirmed
      end
    end

    context 'with invalid params' do
      it 're-renders edit' do
        patch :confirm, params: {
          user: {
            confirmation_token: user.confirmation_token,
            password: nil
          }
        }
        expect(response).to render_template :show
      end
    end
  end
end
