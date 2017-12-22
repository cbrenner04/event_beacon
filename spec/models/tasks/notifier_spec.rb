# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Notifier, type: :model do
  let(:event) { create :event }
  let(:guest) { create :guest, event: event, notification_category: 'both' }
  let(:experience) do
    create :experience, event: event,
                        occurs_at: Time.zone.now,
                        notification_offset: 0
  end
  let(:notification) { create :notification, experience: experience }
  let(:second_experience) do
    create :experience, event: event, occurs_at: Time.zone.now - 10.minutes
  end
  let(:second_notification) do
    create :notification, experience: second_experience
  end
  let(:third_experience) do
    create :experience, event: event, occurs_at: Time.zone.now + 10.minutes
  end
  let(:third_notification) do
    create :notification, experience: third_experience
  end

  before do
    create :guests_notification, guest: guest, notification: notification
    create :guests_notification, guest: guest, notification: second_notification
    create :guests_notification, guest: guest, notification: third_notification
  end

  describe '.send_notifications' do
    it 'sends notifications for experiences that need notifying' do
      expect do
        Tasks::Notifier.send_notifications
      end.to change(MockSmsNotifier.messages, :count).by(1).and(
        change(ActionMailer::Base.deliveries, :count).by(1)
      )
    end
  end

  describe '.send_sms_for' do
    it 'sends sms message' do
      expect do
        Tasks::Notifier.send_sms_for(guest, notification)
      end.to change(MockSmsNotifier.messages, :count).by 1
    end
  end

  describe '.send_email_for' do
    it 'send email message' do
      expect(
        Tasks::Notifier.send_email_for(guest, notification)
      ).to be_a(Mail::Message)
    end
  end
end
