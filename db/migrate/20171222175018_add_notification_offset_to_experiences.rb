class AddNotificationOffsetToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :notification_offset, :integer

    Experience.all.each do |experience|
      experience.notification_offset = 30
      experience.save
    end

    change_column :experiences, :notification_offset, :integer, null: false, default: 30
  end
end
