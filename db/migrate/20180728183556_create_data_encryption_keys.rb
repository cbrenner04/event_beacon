class CreateDataEncryptionKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :data_encryption_keys do |t|
      t.string :encrypted_key, null: false
      t.string :encrypted_key_iv
      t.boolean :primary

      t.timestamps
    end
  end
end
