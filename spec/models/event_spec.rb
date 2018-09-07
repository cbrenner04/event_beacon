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
end
