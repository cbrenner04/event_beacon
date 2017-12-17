class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :sms_body, null: false
      t.text :email_body, null: false
      t.references :experience, foreign_key: true

      t.timestamps
    end
  end
end
