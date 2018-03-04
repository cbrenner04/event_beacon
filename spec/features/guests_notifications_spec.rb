# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Guests Notifications', type: :feature do
  let(:user) { create :user }
  let(:event) { create :event }
  let!(:guest) { create :guest, event: event, first_name: 'Joe' }
  let!(:other_guest) { create :guest, event: event, first_name: 'Boe' }
  let!(:third_guest) { create :guest, event: event, first_name: 'Hoe' }
  let(:experience) { create :experience, event: event }
  let(:notification) { create :notification, experience: experience }
  let(:new_guests_notification_page) { Pages::GuestsNotifications::New.new }

  before { log_in_user user }

  describe 'new' do
    before do
      visit new_event_experience_notification_guests_notification_path(
        event, experience, notification
      )
    end

    it 'allows for guests notifications to be created' do
      new_guests_notification_page.select_guest guest.full_name
      new_guests_notification_page.select_guest other_guest.full_name
      new_guests_notification_page.save

      expect(current_path)
        .to eq event_experience_notification_path(event.id, experience.id,
                                                  notification.id)
      expect(new_guests_notification_page).to have_text guest.full_name
      expect(new_guests_notification_page).to have_text other_guest.full_name
      expect(new_guests_notification_page).to have_no_text third_guest.full_name
    end
  end
end
