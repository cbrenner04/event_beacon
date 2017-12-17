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

    it 'links to guest edit page' do
      find('tr', text: guest.first_name).find('.fa-pencil').click
      expect(current_path)
        .to eq "/events/#{event.id}/guests/#{guest.id}/edit"
    end
  end
end
