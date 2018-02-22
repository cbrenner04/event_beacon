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
      click_on guest.first_name
      find('.fa-pencil').click
      expect(current_path)
        .to eq "/events/#{event.id}/guests/#{guest.id}/edit"
    end

    it 'allows for deletion of guests_notification', :js do
      accept_alert do
        click_on guest.first_name
        find('.fa-trash').click
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
      fill_in 'SMS body', with: 'SMS FOOBAR BODY'
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

    it 'gives current sms link' do
      notification
        .update!(sms_body: "#{notification.sms_body} http://bit.ly/asdf1234")
      page.refresh
      expect(page).to have_text 'Current SMS link: http://long.url'
    end

    it 'updates sms body character count', :js do
      starting_character_count = notification.sms_body.length
      expect(page).to have_text "#{starting_character_count} characters"
      fill_in 'SMS body', with: notification.sms_body + 'f'
      expect(page).to have_text "#{starting_character_count + 1} characters"
    end

    it 'allows for appending a bitly link to the sms body', :js do
      starting_character_count = notification.sms_body.length
      link_url = 'https://www.google.com'
      fill_in 'SMS Link', with: link_url
      click_on 'Append link to SMS body'
      mock_bitly_link = ' short.url'
      sms_body_input_text = find('#notification_sms_body').value
      expect(sms_body_input_text)
        .to eq "#{notification.sms_body}#{mock_bitly_link}"
      new_character_count = starting_character_count + mock_bitly_link.length
      expect(page).to have_text "#{new_character_count} characters"
      expect(page).to have_text "Current SMS link: #{link_url}"
    end

    it 'shows live preview and parses markdown of email body', :js do
      link_text = 'link'
      link_value = 'https://www.google.com'
      fill_in 'Email body', with: "[#{link_text}](#{link_value})"
      email_body_input_text = find('#email-body-preview').text
      wait_for do
        execute_script("$('#notification_email_body').keyup()")
        email_body_input_text = find('#email-body-preview').text
        email_body_input_text == link_text
      end
      expect(email_body_input_text).to eq link_text
      expect(page).to have_css "a[href='#{link_value}']"
    end

    it 're-renders and gives correct error message if information is bad' do
      fill_in 'SMS body', with: ''
      click_on 'Save'
      expect(page).to have_text '1 error prohibited this notification from ' \
                                'being saved:'
      expect(page).to have_text "Sms body can't be blank"
    end
  end
end
