# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create :event }

  describe 'validations' do
    it { expect(event).to be_valid }

    it 'is invalid without name' do
      event.name = nil
      expect(event).to be_invalid
    end

    it 'is invalid without occurs_at' do
      event.occurs_at = nil
      expect(event).to be_invalid
    end

    it 'is invalid without organizer' do
      event.organizer = nil
      expect(event).to be_invalid
    end
  end

  describe 'callbacks' do
    describe 'before_save' do
      describe 'when nickname is not set' do
        it 'saves name as nickname' do
          new_event = Event.new(
            name: 'Foobar',
            occurs_at: Time.zone.now,
            organizer: 'Foobar'
          )
          new_event.save
          new_event.reload
          expect(new_event.nickname).to eq 'Foobar'
        end
      end

      describe 'when nickname is set' do
        it 'does not override nickname' do
          new_event = Event.new(
            name: 'Foobar',
            occurs_at: Time.zone.now,
            nickname: 'Foo',
            organizer: 'Foobar'
          )
          new_event.save
          new_event.reload
          expect(new_event.nickname).to eq 'Foo'
        end
      end
    end
  end

  describe 'unsaved attributes' do
    it 'has welcome email' do
      expect(event.welcome_email)
        .to eq  "Hello,\n\n#{event.organizer} has signed you up for " \
                "notifications for #{event.name}."
    end

    it 'has welcome sms' do
      expect(event.welcome_sms)
        .to eq "#{event.organizer} has signed you up for " \
               "notifications for #{event.name}."
    end
  end
end
