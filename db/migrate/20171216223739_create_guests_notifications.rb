class CreateGuestsNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :guests_notifications do |t|
      t.integer :guest_id, null: false
      t.integer :notification_id, null: false
      t.timestamps
    end

    add_index :guests_notifications, :guest_id
    add_index :guests_notifications, :notification_id
    add_index(:guests_notifications, %i[guest_id notification_id], unique: true)
  end
end
