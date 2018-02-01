# only use in dev
if Rails.env == 'development'
  # run as a transaction
  ActiveRecord::Base.transaction do
    # set up fake users
    foo = User.create(email: 'foo@ex.co', password: 'asdfasdf')
    bar = User.create(email: 'bar@ex.co', password: 'asdfasdf')
    baz = User.create(email: 'baz@ex.co', password: 'asdfasdf')
    p '3 users created'
    # set up an event
    event =
      Event.create(name: 'Test Event 1', occurs_at: Time.zone.now + 180.days)
    p '1 events created'
    # add users to the event
    UsersEvent.create(user: foo, event: event)
    UsersEvent.create(user: bar, event: event)
    p '2 users_events created'
    # add guests to the event
    (0..4).each do |i|
      Guest.create(
        first_name: "Test#{i}",
        last_name: 'Guest',
        phone_number: "123456789#{i}",
        email: "test#{i}@ex.co",
        notification_category: %i[text email both].sample,
        event: event
      )
    end
    p '5 guests created'
    # add experiences to the event
    first = Experience.create(
      name: 'First experience',
      occurs_at: Time.zone.now + 178.days,
      event: event,
      notification_offset: 60
    )
    second = Experience.create(
      name: 'Second experience',
      occurs_at: Time.zone.now + 179.days,
      event: event,
      notification_offset: 45
    )
    p '2 experiences created'
    # add notifications for the experiences
    first_notification = Notification.create(
      sms_body: 'First experience starts in 60 minutes.',
      email_body: 'Hello, First experience starts in 60 minutes. Thanks!',
      experience: first
    )
    second_notification = Notification.create(
      sms_body: 'Second experience starts in 60 minutes.',
      email_body: 'Hello, Second experience starts in 60 minutes. Thanks!',
      experience: second
    )
    p '2 notifications created'
    # add guest notifications
    (0..2).each do |i|
      guest = Guest.find_by(email: "test#{i}@ex.co")
      GuestsNotification.create(guest: guest, notification: first_notification)
    end
    p '3 guests_notifications created for first experience'
    (2..4).each do |i|
      guest = Guest.find_by(email: "test#{i}@ex.co")
      GuestsNotification.create(guest: guest, notification: second_notification)
    end
    p '3 guests_notifications created for second experience'
  end
end
