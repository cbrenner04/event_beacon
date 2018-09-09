# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Confirmation', type: :feature do
  let(:user) do
    create :user,
           confirmed_at: nil,
           password: nil,
           password_confirmation: nil
  end
  let(:confirmation_page) { Pages::Confirmations::New.new }

  describe 'confirm' do
    before do
      visit user_confirmation_path(confirmation_token: user.confirmation_token)
    end

    it 'confirms email and sets password' do
      confirmation_page.set_password_to 'asdfasdf'
      confirmation_page.set_password_confirmation_to 'asdfasdf'
      confirmation_page.save

      expect(page).to have_text 'Events'
      expect(User.find(user.id).confirmed_at).not_to eq nil
    end

    it 're-renders and gives correct error message if information is bad' do
      confirmation_page.set_password_to ''
      confirmation_page.save

      expect(confirmation_page)
        .to have_text '2 errors prohibited this ' \
                      'account from being saved:'
      expect(confirmation_page).to have_text "Password can't be blank"
      expect(confirmation_page)
        .to have_text "Password confirmation can't be blank"

      confirmation_page.set_password_to 'asdfasdf'
      confirmation_page.set_password_confirmation_to 'fdsafdsa'
      confirmation_page.save

      expect(confirmation_page).to have_text '1 error prohibited this ' \
                                             'account from being saved:'
      expect(confirmation_page)
        .to have_text 'Password confirmation does not match password'
    end
  end
end
