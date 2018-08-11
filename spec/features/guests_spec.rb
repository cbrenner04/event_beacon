# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Experiences', type: :feature do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:guest) { build :guest, event: event }
  let(:guests_page) { Pages::Guests::Index.new }
  let(:new_guest_page) { Pages::Guests::New.new }
  let(:edit_guest_page) { Pages::Guests::Edit.new }

  before do
    create :users_event, user: user, event: event
    guest.save
    log_in_user user
  end

  describe 'index' do
    before { visit event_guests_path(event) }

    it 'lists guests related to the event' do
      expect(guests_page).to have_text guest.first_name
      expect(guests_page).to have_text guest.last_name
      expect(guests_page).to have_text 'text, email'
    end

    it 'links to guest edit page' do
      guests_page.select_guest guest.first_name
      guests_page.edit.click

      expect(current_path).to eq edit_event_guest_path(event.id, guest.id)
    end

    it 'allows for deletion of guest', :js do
      guests_page.select_guest guest.first_name
      guests_page.wait_for_accordion_to_open
      accept_alert { guests_page.delete.click }

      guests_page.refresh

      expect(guests_page).to have_no_text guest.first_name
    end
  end

  describe 'new' do
    before { visit new_event_guest_path(event) }

    it 'allows for creating guest information' do
      new_guest_page.set_guest_first_name_to 'Chewy'
      new_guest_page.set_guest_last_name_to 'Solo'
      new_guest_page.set_guest_email_to 'chewy@example.com'
      new_guest_page.save

      expect(current_path).to eq event_guests_path(event.id)
      expect(new_guest_page).to have_text 'Chewy Solo'
    end

    it 're-renders and gives correct error message if information is bad' do
      new_guest_page.set_guest_first_name_to ''
      new_guest_page.set_guest_last_name_to ''
      new_guest_page.set_guest_email_to guest.email
      new_guest_page.set_guest_phone_to guest.phone_number
      new_guest_page.save

      expect(new_guest_page).to have_text '4 errors prohibited this guest ' \
                                          'from being saved:'
      expect(new_guest_page).to have_text "First name can't be blank"
      expect(new_guest_page).to have_text "Last name can't be blank"
      expect(new_guest_page)
        .to have_text 'Phone number - It looks like the guest shares a phone ' \
                      'number with another guest. If this is the case, ' \
                      'please leave phone number blank.'
      expect(new_guest_page)
        .to have_text 'Email - It looks like the guest shares an email with ' \
                      'another guest. If this is the case, please leave ' \
                      'email blank.'
    end
  end

  describe 'edit' do
    before { visit edit_event_guest_path(event, guest) }

    it 'displays guest' do
      expect(edit_guest_page).to have_text guest.first_name
    end

    it 'allows for updating guest information' do
      edit_guest_page.set_guest_first_name_to 'Chewy'
      edit_guest_page.set_guest_last_name_to 'Solo'
      edit_guest_page.save

      expect(current_path).to eq event_guests_path(event.id)
      expect(edit_guest_page).to have_text 'Chewy Solo'
    end

    it 're-renders and gives correct error message if information is bad' do
      edit_guest_page.set_guest_first_name_to ''
      edit_guest_page.set_guest_last_name_to ''
      edit_guest_page.save

      expect(edit_guest_page).to have_text '2 errors prohibited this guest ' \
                                           'from being saved:'
      expect(edit_guest_page).to have_text "First name can't be blank"
      expect(edit_guest_page).to have_text "Last name can't be blank"
    end
  end
end
