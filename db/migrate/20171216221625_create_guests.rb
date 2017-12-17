class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.integer :notification_category
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
