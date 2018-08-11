class RemoveNewlyEncryptedFieldsFromGuests < ActiveRecord::Migration[5.1]
  def change
    remove_column :guests, :email
    remove_column :guests, :phone_number
  end
end
