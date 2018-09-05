# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :feature do
  let(:user) { create :user }
  let(:new_contact_page) { Pages::Contacts::New.new }

  describe 'new' do
    describe 'when signed in' do
      before do
        sign_in user
        visit contact_us_path
      end

      it 'creates contact' do
        new_contact_page.set_subject_to 'Foo'
        new_contact_page.set_body_to 'Bar'
        new_contact_page.save

        expect(current_path).to eq root_path
        expect(Contact.last.user_id).to eq user.id
        expect(Contact.last.subject).to eq 'Foo'
        expect(Contact.last.body).to eq 'Bar'
      end

      it 're-renders and gives correct error message if information is bad' do
        new_contact_page.set_subject_to ''
        new_contact_page.save

        expect(new_contact_page).to have_text '2 errors prohibited this ' \
                                              'contact_us from being saved:'
        expect(new_contact_page).to have_text "Subject can't be blank"
        expect(new_contact_page).to have_text "Body can't be blank"
      end
    end

    describe 'when not signed in' do
      before { visit contact_us_path }

      it 'creates contact' do
        new_contact_page.set_subject_to 'Foo'
        new_contact_page.set_body_to 'Bar'
        new_contact_page.save

        expect(current_path).to eq new_user_session_path
        expect(Contact.last.user_id).to eq nil
        expect(Contact.last.subject).to eq 'Foo'
        expect(Contact.last.body).to eq 'Bar'
      end

      it 're-renders and gives correct error message if information is bad' do
        new_contact_page.set_subject_to ''
        new_contact_page.save

        expect(new_contact_page).to have_text '2 errors prohibited this ' \
                                              'contact_us from being saved:'
        expect(new_contact_page).to have_text "Subject can't be blank"
        expect(new_contact_page).to have_text "Body can't be blank"
      end
    end
  end
end
