# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Experiences', type: :feature do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:guest) { create :guest, event: event }
  let(:experience) { create :experience, event: event }
  let(:notification) { create :notification, experience: experience }

  before do
    create :guests_notification, guest: guest, notification: notification
    log_in_user user
  end

  describe 'show' do
    before do
      visit event_experience_notification_path(event, experience, notification)
    end

    it 'lists related sms body' do
      expect(page).to have_text notification.sms_body
    end

    it 'lists related email body' do
      expect(page).to have_text notification.email_body
    end

    it 'lists related guests' do
      expect(page).to have_text guest.full_name
    end

    it 'links to edit page' do
      click_on 'Edit'
      expect(current_path).to eq "/events/#{event.id}/experiences/" \
                                 "#{experience.id}/notifications/" \
                                 "#{notification.id}/edit"
    end

    it 'links to guest edit page' do
      find('tr', text: guest.first_name).find('.fa-pencil').click
      expect(current_path)
        .to eq "/events/#{event.id}/guests/#{guest.id}/edit"
    end

    it 'allows for deletion of guests_notification', :js do
      accept_alert do
        find('tr', text: guest.first_name).find('.fa-trash').click
      end
      page.refresh
      expect(page).to have_no_text guest.first_name
    end
  end

  describe 'edit' do
    before do
      visit edit_event_experience_notification_path(event, experience,
                                                    notification)
    end

    it 'displays notification' do
      expect(page).to have_text notification.sms_body
    end

    it 'allows for updating notification information' do
      fill_in 'Sms body', with: 'SMS FOOBAR BODY'
      fill_in 'Email body', with: 'EMAIL FOOBAZ BODY'
      click_on 'Save'
      expect(current_path).to eq "/events/#{event.id}/experiences/" \
                                 "#{experience.id}/notifications/" \
                                 "#{notification.id}"
      expect(page).to have_text 'SMS FOOBAR BODY'
      expect(page).to have_text 'EMAIL FOOBAZ BODY'
    end

    it 'gives sms body character count' do
      character_count = notification.sms_body.length
      expect(page).to have_text "#{character_count} characters"
    end

    it 'updates sms body character count', :js do
      starting_character_count = notification.sms_body.length
      expect(page).to have_text "#{starting_character_count} characters"
      fill_in 'Sms body', with: notification.sms_body + 'f'
      expect(page).to have_text "#{starting_character_count + 1} characters"
    end

    it 're-renders and gives correct error message if information is bad' do
      fill_in 'Sms body', with: ''
      click_on 'Save'
      expect(page).to have_text '1 error prohibited this notification from ' \
                                'being saved:'
      expect(page).to have_text "Sms body can't be blank"
    end
  end
end
