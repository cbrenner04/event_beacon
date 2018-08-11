# frozen_string_literal: true

namespace :encryption do
  desc 'Rotates DEK'
  task rotate_dek: :environment do
    new_dek = DataEncryptionKey.generate!
    new_dek.promote!

    EncryptedField.find_each do |field|
      field.reencrypt!(new_dek)
    end

    DataEncryptionKey.unused.each(&:destroy)
  end
end
