# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'End User Agreement', type: :feature do
  let(:user) { create :user }

  describe 'show' do
    describe 'when logged in' do
      before do
        sign_in user
        visit end_user_agreement_path
      end

      it 'displays EULA' do
        expect(page).to have_text 'End-User License Agreement ("Agreement")'
      end
    end

    describe 'when not logged in' do
      before { visit end_user_agreement_path }

      it 'displays EULA' do
        expect(page).to have_text 'End-User License Agreement ("Agreement")'
      end
    end
  end
end
