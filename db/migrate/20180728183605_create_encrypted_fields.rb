class CreateEncryptedFields < ActiveRecord::Migration[5.1]
  def change
    create_table :encrypted_fields do |t|
      t.string :encrypted_blob, null: false
      t.string :encrypted_blob_iv
      t.references :data_encryption_key, foreign_key: true, null: false

      t.timestamps
    end
  end
end
