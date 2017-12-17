# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'validations' do
    it { expect(user).to be_valid }

    it 'is invalid without email' do
      user.email = nil
      expect(user).to be_invalid
    end
  end
end
