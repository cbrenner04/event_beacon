# frozen_string_literal: true

require 'aes'

# model for DEK
class DataEncryptionKey < ApplicationRecord
  has_many :encrypted_fields,
           inverse_of: :data_encryption_key,
           dependent: :restrict_with_exception

  attr_encrypted :key, mode: :per_attribute_iv, key: :key_encryption_key

  validates :key, presence: true

  def self.primary
    find_by(primary: true)
  end

  def self.generate!(attrs = {})
    create!(attrs.merge(key: AES.key))
  end

  def self.unused
    where(primary: false).select do |key|
      EncryptedField.where(data_encryption_key_id: key.id).none?
    end
  end

  def promote!
    transaction do
      DataEncryptionKey.primary&.update!(primary: false)
      update!(primary: true)
    end
  end

  def reencrypt!
    # assigning the key will trigger encryption with the new key
    update!(key: key)
  end

  private

  def key_encryption_key
    Rails.application.secrets.key_encryption_key
  end
end
