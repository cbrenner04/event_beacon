class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :occurs_at, null: false

      t.timestamps
    end
  end
end
