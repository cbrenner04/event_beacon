# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Experience, type: :model do
  let(:experience) { create :experience }

  describe 'validations' do
    it { expect(experience).to be_valid }

    it 'is invalid without name' do
      experience.name = nil
      expect(experience).to be_invalid
    end

    it 'is invalid without occurs_at' do
      experience.occurs_at = nil
      expect(experience).to be_invalid
    end
  end

  describe '#needs_notifying?' do
    it 'returns true if occurs_at is within ten minutes' do
      expect(experience.needs_notifying?).to eq false
      experience.update!(occurs_at: Time.zone.now - 500)
      expect(experience.needs_notifying?).to eq true
    end
  end
end
