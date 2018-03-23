# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  let(:event) { create :event }
  let(:guest) { create :guest, event: event }
  let!(:other_guest) { create :guest, event: event }

  describe 'validations' do
    it { expect(guest).to be_valid }

    it 'is invalid without first_name and last_name' do
      guest.first_name = nil
      guest.last_name = nil
      expect(guest).to be_invalid
    end

    it 'is invalid if email is duplicate' do
      guest.email = other_guest.email
      expect(guest).to be_invalid
    end

    it 'is invalid if phone is duplicate' do
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
end
