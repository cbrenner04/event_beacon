class CreateUsersEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :users_events do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.timestamps
    end

    add_index :users_events, :user_id
    add_index :users_events, :event_id
    add_index(:users_events, %i[user_id event_id], unique: true)
  end
end
