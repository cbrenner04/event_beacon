class AddEncryptedFieldIdsToGuests < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :email_encrypted_field_id, :integer
    add_column :guests, :phone_number_encrypted_field_id, :integer
  end
end
