# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataEncryptionKey, type: :model do
  let(:primary_encryption_key) { build :data_encryption_key }
  let(:other_encryption_key) { build :data_encryption_key, primary: false }

  describe 'validations' do
    it { expect(primary_encryption_key).to be_valid }
  end

  describe '.primary' do
    before(:each) do
      DataEncryptionKey.destroy_all
      primary_encryption_key.save
      other_encryption_key.save
    end

    it { expect(DataEncryptionKey.primary).to eq primary_encryption_key }
  end

  describe '.generate!' do
    before(:each) { DataEncryptionKey.destroy_all }

    it 'creates DataEncryptionKey' do
      expect { DataEncryptionKey.generate! }
        .to change(DataEncryptionKey, :count).by 1
    end
  end

  describe '.unused' do
    before(:each) do
      DataEncryptionKey.destroy_all
      primary_encryption_key.save
      other_encryption_key.save
    end

    it { expect(DataEncryptionKey.unused.count).to eq 1 }
    it { expect(DataEncryptionKey.unused).to include other_encryption_key }
  end

  describe '#promote!' do
    before(:each) do
      DataEncryptionKey.destroy_all
      other_encryption_key.save
    end

    it 'updates primary' do
      expect { other_encryption_key.promote! }
        .to change { other_encryption_key.primary }.from(false).to(true)
    end
  end

  describe '#reencrypt!' do
    before(:each) do
      DataEncryptionKey.destroy_all
      other_encryption_key.save
    end

    it 'updates data' do
      expect { other_encryption_key.reencrypt! }
        .to(change { other_encryption_key.encrypted_key })
    end
  end
end
