class UpdateGuestsToUseEncryptedFields < ActiveRecord::Migration[5.1]
  def change
    Guest.find_each do |guest|
      guest.update!(
        email: guest.email,
        phone_number: guest.phone_number
      )
    end
  end
end
