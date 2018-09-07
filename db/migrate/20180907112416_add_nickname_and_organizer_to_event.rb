class AddNicknameAndOrganizerToEvent < ActiveRecord::Migration[5.1]
  def up
    add_column :events, :nickname, :string
    add_column :events, :organizer, :string

    Event.all.each do |event|
      user_event = UsersEvent.find_by(event_id: event.id)
      user = User.find(user_event.user_id)
      email = user.email
      event.organizer = email
      event.nickname = event.name
      event.save
    end

    change_column :events, :nickname, :string, null: false
    change_column :events, :organizer, :string, null: false
  end

  def down
    remove_column :events, :nickname
    remove_column :events, :organizer
  end
end
