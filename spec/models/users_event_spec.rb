# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersEvent, type: :model do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:users_event) { create :users_event, user: user, event: event }

  describe 'validations' do
    it { expect(users_event).to be_valid }

    it 'is invalid without user' do
      users_event.user = nil
      expect(users_event).to be_invalid
    end

    it 'is invalid without event' do
      users_event.event = nil
      expect(users_event).to be_invalid
    end

    it 'is invalid with same user, event combination' do
      # because let's are lazy
      users_event
      new_users_event = build :users_event, user: user, event: event
      expect(new_users_event).to be_invalid
    end
  end
end
