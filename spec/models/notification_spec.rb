# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { create :notification }

  describe 'validations' do
    it { expect(notification).to be_valid }

    it 'is invalid without sms_body' do
      notification.sms_body = nil
      expect(notification).to be_invalid
    end

    it 'is invalid without email_body' do
      notification.email_body = nil
      expect(notification).to be_invalid
    end
  end
end
