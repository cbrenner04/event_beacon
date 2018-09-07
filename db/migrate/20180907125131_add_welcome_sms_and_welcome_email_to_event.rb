class AddWelcomeSmsAndWelcomeEmailToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :welcome_sms, :text
    add_column :events, :welcome_email, :text
  end
end
