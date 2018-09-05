class ChangeContactsUserIdNullTrue < ActiveRecord::Migration[5.1]
  def change
    change_column_null :contacts, :user_id, true
  end
end
