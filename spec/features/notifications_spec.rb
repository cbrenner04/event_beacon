# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Experiences', type: :feature do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:guest) { build :guest, event: event }
  let(:other_guest) { build :guest, event: event }
  let(:experience) { create :experience, event: event }
  let(:notification) { create :notification, experience: experience }
  let(:notification_page) { Pages::Notifications::Show.new }
  let(:edit_notification_page) { Pages::Notifications::Edit.new }

  before do
    [guest, other_guest].each(&:save)
    create :guests_notification, guest: guest, notification: notification
    create :guests_notification, guest: other_guest, notification: notification
    log_in_user user
  end

  describe 'show' do
    before do
      visit event_experience_notification_path(event, experience, notification)
    end

    it 'lists related sms body' do
      expect(notification_page).to have_text notification.sms_body
    end

    it 'lists related email body' do
      expect(notification_page).to have_text notification.email_body
    end

    it 'lists related guests' do
      expect(notification_page).to have_text guest.full_name
    end

    it 'links to edit experience page' do
      notification_page.navigate_to_edit_experience_timing

      expect(current_path)
        .to eq edit_event_experience_path(event.id, experience.id)
    end

    it 'links to edit notification body page' do
      notification_page.navigate_to_edit_notification_body

      expect(current_path)
        .to eq edit_event_experience_notification_path(event.id, experience.id,
                                                       notification.id)
    end

    it 'links to guest edit page', :js do
      notification_page.select_guest guest.first_name
      notification_page.wait_for_accordion_to_open
      notification_page.edit.click

      expect(current_path).to eq edit_event_guest_path(event.id, guest.id)
    end

    it 'allows for deletion of guests_notification', :js do
      notification_page.select_guest guest.first_name
      notification_page.wait_for_accordion_to_open
      accept_alert { notification_page.delete.click }

      notification_page.refresh

      expect(notification_page).to have_no_text guest.first_name
    end

    describe 'when an attached guest is deleted' do
      it 'list related guests' do
        guest.destroy

        notification_page.refresh

        expect(notification_page).to_not have_text guest.full_name
        expect(notification_page).to have_text other_guest.full_name
      end
    end
  end

  describe 'edit' do
    before do
      visit edit_event_experience_notification_path(event, experience,
                                                    notification)
    end

    it 'displays notification' do
      expect(edit_notification_page).to have_text notification.sms_body
    end

    it 'allows for updating notification information' do
      sms_body = 'SMS FOOBAR BODY'
      email_body = 'EMAIL FOOBAZ BODY'

      edit_notification_page.set_sms_body_to sms_body
      edit_notification_page.set_email_body_to email_body
      edit_notification_page.save

      expect(current_path)
        .to eq event_experience_notification_path(event.id, experience.id,
                                                  notification.id)
      expect(edit_notification_page).to have_text sms_body
      expect(edit_notification_page).to have_text email_body
    end

    it 'gives sms body character count' do
      expect(edit_notification_page)
        .to have_text "#{notification.sms_body.length} characters"
    end

    it 'gives current sms link' do
      notification
        .update!(sms_body: "#{notification.sms_body} http://bit.ly/asdf1234")
      edit_notification_page.refresh

      expect(edit_notification_page)
        .to have_text 'Current SMS link: http://long.url'
    end

    it 'updates sms body character count', :js do
      starting_character_count = notification.sms_body.length

      expect(edit_notification_page)
        .to have_text "#{starting_character_count} characters"

      edit_notification_page.set_sms_body_to notification.sms_body + 'f'

      expect(edit_notification_page)
        .to have_text "#{starting_character_count + 1} characters"
    end

    it 'allows for appending a bitly link to the sms body', :js do
      starting_character_count = notification.sms_body.length
      link_url = 'https://www.google.com'
      edit_notification_page.set_sms_link_to link_url
      edit_notification_page.append_sms_link

      mock_bitly_link = ' short.url'
      sms_body_input_text = ''

      wait_for do
        sms_body_input_text = edit_notification_page.sms_body.value
        sms_body_input_text.include? mock_bitly_link
      end

      expect(sms_body_input_text)
        .to eq "#{notification.sms_body}#{mock_bitly_link}"

      new_character_count = starting_character_count + mock_bitly_link.length

      expect(edit_notification_page)
        .to have_text "#{new_character_count} characters"
      expect(edit_notification_page)
        .to have_text "Current SMS link: #{link_url}"
    end

    it 'shows live preview and parses markdown of email body', :js do
      link_text = 'link'
      link_value = 'https://www.google.com'

      edit_notification_page.set_email_body_to "[#{link_text}](#{link_value})"
      email_body_input_text = ''

      wait_for do
        edit_notification_page.mock_key_up
        email_body_input_text = edit_notification_page.email_preview.text
        email_body_input_text == link_text
      end

      expect(email_body_input_text).to eq link_text
      expect(edit_notification_page).to have_css "a[href='#{link_value}']"
    end

    it 're-renders and gives correct error message if information is bad' do
      edit_notification_page.set_sms_body_to ''
      edit_notification_page.save

      expect(edit_notification_page).to have_text '1 error prohibited this ' \
                                                  'notification from being ' \
                                                  'saved:'
      expect(edit_notification_page).to have_text "Sms body can't be blank"
    end
  end
end
