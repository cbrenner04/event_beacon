# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EncryptedField, type: :model do
  let(:encrypted_field) { build :encrypted_field }
  let(:data_encryption_key) { build :data_encryption_key, primary: false }

  describe 'validations' do
    it { expect(encrypted_field).to be_valid }
  end

  describe '#reencrypt!' do
    before(:each) do
      encrypted_field.save
      data_encryption_key.save
    end

    it 'updates data' do
      expect { encrypted_field.reencrypt!(data_encryption_key) }
        .to(change { encrypted_field.encrypted_blob })
    end
  end
end
