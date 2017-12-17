# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  let(:guest) { create :guest }

  describe 'validations' do
    it { expect(guest).to be_valid }

    it 'is invalid without first_name and last_name' do
      guest.first_name = nil
      guest.last_name = nil
      expect(guest).to be_invalid
    end

    it 'is invalid without email and phone_number' do
      guest.email = nil
      guest.phone_number = nil
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
