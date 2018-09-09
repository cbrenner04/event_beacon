# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrivacyPoliciesController do
  let(:user) { create :user }

  before { sign_in user }

  describe 'GET #show' do
    it 'returns ok' do
      get :show

      expect(response.status).to eq 200
    end
  end
end
