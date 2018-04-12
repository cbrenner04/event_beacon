require 'faker'

# only use in dev
if Rails.env == 'development'
  # run as a transaction
  ActiveRecord::Base.transaction do
    # set up fake users
    foo = User.create(email: 'foo@ex.co', password: 'asdfasdf')
    bar = User.create(email: 'bar@ex.co', password: 'asdfasdf')
    User.create(email: 'baz@ex.co', password: 'asdfasdf')
    p '3 users created'
    # set up an event
    event =
      Event.create(name: 'The best day ever',
                   occurs_at: Time.zone.now + 180.days)
    p '1 events created'
    # add users to the event
    UsersEvent.create(user: foo, event: event)
    UsersEvent.create(user: bar, event: event)
    p '2 users_events created'
    # add guests to the event
    guest_1 = Guest.create(
      first_name: first_name = Faker::Name.unique.first_name,
      last_name: last_name = Faker::Name.unique.last_name,
      phone_number: Faker::PhoneNumber.cell_phone.gsub!(/[^0-9]/, ''),
      email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
      notification_category: %i[text email both].sample,
      event: event
    )
    guest_2 = Guest.create(
      first_name: first_name = Faker::Name.unique.first_name,
      last_name: last_name = Faker::Name.unique.last_name,
      phone_number: Faker::PhoneNumber.cell_phone.gsub!(/[^0-9]/, ''),
      email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
      notification_category: %i[text email both].sample,
      event: event
    )
    guest_3 = Guest.create(
      first_name: first_name = Faker::Name.unique.first_name,
      last_name: last_name = Faker::Name.unique.last_name,
      phone_number: Faker::PhoneNumber.cell_phone,
      email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
      notification_category: %i[text email both].sample,
      event: event
    )
    guest_4 = Guest.create(
      first_name: first_name = Faker::Name.unique.first_name,
      last_name: last_name = Faker::Name.unique.last_name,
      phone_number: Faker::PhoneNumber.cell_phone,
      email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
      notification_category: %i[text email both].sample,
      event: event
    )
    guest_5 = Guest.create(
      first_name: first_name = Faker::Name.unique.first_name,
      last_name: last_name = Faker::Name.unique.last_name,
      phone_number: Faker::PhoneNumber.cell_phone,
      email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
      notification_category: %i[text email both].sample,
      event: event
    )
    p '5 guests created'
    # add experiences to the event
    first = Experience.create(
      name: 'Breakfast',
      occurs_at: Time.zone.now + 178.days,
      event: event,
      notification_offset: 60
    )
    second = Experience.create(
      name: 'Elevensies',
      occurs_at: Time.zone.now + 179.days,
      event: event,
      notification_offset: 45
    )
    p '2 experiences created'
    # add notifications for the experiences
    first_notification = Notification.create(
      sms_body: 'Breakfast starts in 60 minutes.',
      email_body: 'Hello, Breakfast starts in 60 ' \
                  'minutes. Thanks!',
      experience: first
    )
    second_notification = Notification.create(
      sms_body: 'Elevensies starts in 60 minutes.',
      email_body: 'Hello, Elevensies starts in 60 ' \
                  'minutes. Thanks!',
      experience: second
    )
    p '2 notifications created'
    # add guest notifications
    [guest_1, guest_2, guest_3].each do |guest|
      GuestsNotification.create(guest: guest, notification: first_notification)
    end
    p '3 guests_notifications created for first experience'
    [guest_3, guest_4, guest_5].each do |guest|
      GuestsNotification.create(guest: guest, notification: second_notification)
    end
    p '3 guests_notifications created for second experience'
  end
end
