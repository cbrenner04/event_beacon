# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuestsNotification, type: :model do
  let(:guest) { create :guest }
  let(:notification) { create :notification }
  let(:guests_notification) do
    create :guests_notification, guest: guest, notification: notification
  end

  describe 'validations' do
    it { expect(guests_notification).to be_valid }

    it 'is invalid without guest' do
      guests_notification.guest = nil
      expect(guests_notification).to be_invalid
    end

    it 'is invalid without notification' do
      guests_notification.notification = nil
      expect(guests_notification).to be_invalid
    end

    it 'is invalid with same guest, notification combination' do
      # because let's are lazy
      guests_notification
      new_guests_notification =
        build :guests_notification, guest: guest, notification: notification
      expect(new_guests_notification).to be_invalid
    end
  end
end
