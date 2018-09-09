class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :subject, null: false
      t.text :body, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
