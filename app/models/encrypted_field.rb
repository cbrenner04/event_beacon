# frozen_string_literal: true

# generic model for any encrypted data in app
class EncryptedField < ApplicationRecord
  belongs_to :data_encryption_key, inverse_of: :encrypted_fields
  has_many :guests, inverse_of: :encrypted_field, dependent: :destroy

  attr_encrypted :blob, mode: :per_attribute_iv, key: :encryption_key

  validates :blob, :data_encryption_key_id, presence: true

  def reencrypt!(new_key)
    # assigning the blob will trigger encryption with the new key
    update!(data_encryption_key: new_key, blob: blob)
  end

  private

  def encryption_key
    self.data_encryption_key ||= DataEncryptionKey.primary
    data_encryption_key.key
  end
end
