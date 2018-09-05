# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Privacy Policy', type: :feature do
  let(:user) { create :user }

  describe 'show' do
    describe 'when logged in' do
      before do
        sign_in user
        visit privacy_policy_path
      end

      it 'displays EULA' do
        expect(page).to have_text 'Privacy Policy'
      end
    end

    describe 'when not logged in' do
      before { visit privacy_policy_path }

      it 'displays EULA' do
        expect(page).to have_text 'Privacy Policy'
      end
    end
  end
end
