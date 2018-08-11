# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Guests Notifications' do
  let(:user) { create :user }
  # for event with guests
  let(:event) { create :event }
  let(:guest) { build :guest, event: event, first_name: 'Joe' }
  let(:other_guest) { build :guest, event: event, first_name: 'Boe' }
  let(:third_guest) { build :guest, event: event, first_name: 'Hoe' }
  let(:experience) { create :experience, event: event }
  let(:notification) { create :notification, experience: experience }
  # for event without guests
  let(:other_event) { create :event }
  let(:other_experience) { create :experience, event: other_event }
  let(:other_notification) do
    create :notification, experience: other_experience
  end
  let(:new_guests_notification_page) { Pages::GuestsNotifications::New.new }

  before { log_in_user user }

  describe 'new' do
    context 'when guests exist for event' do
      before do
        [guest, other_guest, third_guest].each(&:save)
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
        expect(new_guests_notification_page)
          .to have_no_text third_guest.full_name
      end
    end

    context 'when guest do not exist for event' do
      before do
        visit new_event_experience_notification_guests_notification_path(
          other_event, other_experience, other_notification
        )
      end

      it 'links to adding guests to event' do
        expect(page).to have_text(
          new_guests_notification_page.add_guests_helper_text(other_experience)
        )
        new_guests_notification_page.select_add_guests_link
        expect(current_path).to eq event_guests_path(other_event)
      end
    end
  end
end
