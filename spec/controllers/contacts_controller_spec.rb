# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsController do
  let(:user) { create :user }

  before { sign_in user }

  describe 'GET #new' do
    it 'assigns the contact as @contact' do
      get :new

      expect(assigns(:contact)).to be_a_new(Contact)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates contact' do
        expect do
          post :create, params: {
            contact: {
              subject: 'foo',
              body: 'bar'
            }
          }
        end.to change(Contact, :count).by 1
      end
    end

    context 'with invalid params' do
      it 're-renders new' do
        post :create, params: {
          contact: {
            subject: nil
          }
        }
        expect(response).to render_template :new
      end
    end
  end
end
