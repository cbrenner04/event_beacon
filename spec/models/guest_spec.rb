# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  let(:event) { create :event }
  let(:guest) { create :guest, event: event }
  let(:other_guest) { build :guest, event: event }

  describe 'validations' do
    it { expect(guest).to be_valid }

    it 'is invalid without first_name and last_name' do
      guest.first_name = nil
      guest.last_name = nil
      expect(guest).to be_invalid
    end

    it 'is invalid if email is duplicate' do
      other_guest.save
      guest.email = other_guest.email
      expect(guest).to be_invalid
    end

    it 'is invalid if phone is duplicate' do
      other_guest.save
      guest.phone_number = other_guest.phone_number
      expect(guest).to be_invalid
    end
  end

  describe '#full_name' do
    it 'returns the full name' do
      guest.first_name = 'foo'
      guest.last_name = 'bar'
      expect(guest.full_name).to eq 'foo bar'
    end
  end

  describe 'callbacks' do
    describe 'after_create' do
      it 'sends welcome notifications' do
        guest = Guest.create!(
          event: event,
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@example.com',
          phone_number: '1234567890',
          notification_category: 'both'
        )
        guest.reload
        expect(guest.welcome_email_sent_at).to_not be_nil
        expect(guest.welcome_sms_sent_at).to_not be_nil
      end
    end

    describe 'after_update' do
      describe 'when notification category does not change' do
        it 'does not send notifications' do
          expect do
            guest.update!(first_name: 'Foobar')
          end.to_not(change { guest })
        end
      end

      describe 'when notification category changes from email to text' do
        it 'sends text initial text notification' do
          guest = Guest.create!(
            event: event,
            first_name: 'Foo',
            last_name: 'Bar',
            email: 'foo@example.com',
            phone_number: '1234567890',
            notification_category: 'email'
          )
          guest.reload
          expect(guest.welcome_sms_sent_at).to be_nil
          expect do
            guest.update!(notification_category: 'text')
          end.to(change { guest.welcome_sms_sent_at })
          expect(guest.welcome_sms_sent_at).to_not be_nil
        end
      end

      describe 'when notification category changes from text to email' do
        it 'sends initial email notification' do
          guest = Guest.create!(
            event: event,
            first_name: 'Foo',
            last_name: 'Bar',
            email: 'foo@example.com',
            phone_number: '1234567890',
            notification_category: 'text'
          )
          guest.reload
          expect(guest.welcome_email_sent_at).to be_nil
          expect do
            guest.update!(notification_category: 'email')
          end.to(change { guest.welcome_email_sent_at })
          expect(guest.welcome_email_sent_at).to_not be_nil
        end
      end

      describe 'when notification category changes from email to both' do
        it 'sends initial text notifications' do
          guest = Guest.create!(
            event: event,
            first_name: 'Foo',
            last_name: 'Bar',
            email: 'foo@example.com',
            phone_number: '1234567890',
            notification_category: 'email'
          )
          guest.reload
          expect(guest.welcome_sms_sent_at).to be_nil
          expect do
            guest.update!(notification_category: 'both')
          end.to(change { guest.welcome_sms_sent_at })
          expect(guest.welcome_sms_sent_at).to_not be_nil
        end
      end

      describe 'when notification category changes from text to both' do
        it 'sends initial email notifications' do
          guest = Guest.create!(
            event: event,
            first_name: 'Foo',
            last_name: 'Bar',
            email: 'foo@example.com',
            phone_number: '1234567890',
            notification_category: 'text'
          )
          guest.reload
          expect(guest.welcome_email_sent_at).to be_nil
          expect do
            guest.update!(notification_category: 'both')
          end.to(change { guest.welcome_email_sent_at })
          expect(guest.welcome_email_sent_at).to_not be_nil
        end
      end
    end
  end
end
