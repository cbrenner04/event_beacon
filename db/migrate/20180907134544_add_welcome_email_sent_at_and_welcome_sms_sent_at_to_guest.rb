class AddWelcomeEmailSentAtAndWelcomeSmsSentAtToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :welcome_email_sent_at, :datetime
    add_column :guests, :welcome_sms_sent_at, :datetime
  end
end
