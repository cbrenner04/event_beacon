# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortUrlsController do
  let(:user) { create :user }

  before { sign_in user }

  describe 'GET #show' do
    it 'returns a plain text short url' do
      get :show, params: {
        link: 'https://www.google.com'
      }

      expect(response.body).to eq 'short.url'
    end
  end
end
