class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :name, null: false
      t.datetime :occurs_at, null: false
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
