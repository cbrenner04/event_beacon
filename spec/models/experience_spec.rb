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
end
