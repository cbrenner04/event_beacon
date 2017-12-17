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

  before { log_in_user user }

  describe 'new' do
    before do
      visit new_event_experience_notification_guests_notification_path(
        event, experience, notification
      )
    end

    it 'allows for guests notifications to be created' do
      check guest.full_name
      check other_guest.full_name
      click_on 'Save'
      expect(current_path).to eq "/events/#{event.id}/experiences/" \
                                 "#{experience.id}/notifications/" \
                                 "#{notification.id}"
      expect(page).to have_text guest.full_name
      expect(page).to have_text other_guest.full_name
      expect(page).to have_no_text third_guest.full_name
    end
  end
end
