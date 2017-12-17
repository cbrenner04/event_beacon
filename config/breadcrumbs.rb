crumb :root do
  link "Events", root_path
end

crumb :event do |event|
  link event.name, event_path(event)
end

crumb :guests do |event|
  link "Guests", event_guests_path(event)
  parent :event, event
end

crumb :edit_guest do |event, guest|
  link "Edit #{guest.full_name}", edit_event_guest_path(event, guest)
  parent :guests, event
end

crumb :experiences do |event|
  link "Experiences", event_experiences_path(event)
  parent :event, event
end

crumb :edit_experience do |event, experience|
  link "Edit #{experience.name}", edit_event_experience_path(event, experience)
  parent :experiences, event
end

crumb :notification do |event, experience, notification|
  link "#{experience.name} Notification",
       event_experience_notification_path(event, experience, notification)
  parent :experiences, event
end

crumb :edit_notification do  |event, experience, notification|
  link "Edit #{experience.name} Notification",
       edit_event_experience_notification_path(event, experience, notification)
  parent :notification, event, experience, notification
end
