# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { create :contact }

  describe 'validations' do
    it { expect(contact).to be_valid }

    it 'is invalid without subject' do
      contact.subject = nil
      expect(contact).to be_invalid
    end

    it 'is invalid without body' do
      contact.body = nil
      expect(contact).to be_invalid
    end
  end
end
