# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Terms and Conditions', type: :feature do
  let(:user) { create :user }

  describe 'show' do
    describe 'when logged in' do
      before do
        sign_in user
        visit terms_and_conditions_path
      end

      it 'displays EULA' do
        expect(page).to have_text 'Terms and Conditions'
      end
    end

    describe 'when not logged in' do
      before { visit terms_and_conditions_path }

      it 'displays EULA' do
        expect(page).to have_text 'Terms and Conditions'
      end
    end
  end
end
