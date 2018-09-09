# frozen_string_literal: true

require 'sms_notifier'
require 'notification_boilerplate'

module Tasks
  # sends notification to guests
  class Notifier
    def self.send_the_notifications(guests, notification, default = true)
      guests.each do |guest|
        nc = guest.notification_category
        next if nc.nil?
        send_sms_for(guest, notification) if %w[text both].include? nc
        if %w[email both].include? nc
          send_email_for(guest, notification, default)
        end
      end
    end

    def self.send_to_all_now(notification)
      send_the_notifications(notification.experience.event.guests, notification)
    end

    def self.send_notifications
      notifications = Notification.all
      notifications.each do |notification|
        next unless notification.experience.needs_notifying?
        send_the_notifications(notification.guests, notification, false)
      end
    end

    def self.send_first_notification(guest)
      nc = guest.notification_category
      return if nc.nil?
      event = guest.event
      email_body =
        "#{event.welcome_email} #{NotificationBoilerplate.email_boilerplate}"
      sms_body =
        "#{event.welcome_sms} #{NotificationBoilerplate.sms_boilerplate}"
      send_first_sms_for(guest, sms_body) if %w[text both].include? nc
      return unless %w[email both].include? nc
      send_first_email_for(guest, email_body)
    end

    def self.send_first_sms_for(guest, message)
      logger.info "sending first sms to guest #{guest.id}"
      SmsNotifier.send_sms(number: guest.phone_number,
                           message: message)
      guest.update(welcome_sms_sent_at: Time.zone.now)
    end

    def self.send_sms_for(guest, notification)
      logger.info "sending sms to guest #{guest.id} for " \
                  "notification #{notification.id}"
      SmsNotifier.send_sms(number: guest.phone_number,
                           message: notification.sms_body)
    end

    def self.send_first_email_for(guest, message)
      logger.info "sending first email to guest #{guest.id}"
      NotificationMailer.email(
        guest_email: guest.email,
        subject: "You've been signed up for notifications",
        message: message
      ).deliver_later
      guest.update(welcome_email_sent_at: Time.zone.now)
    end

    def self.send_email_for(guest, notification, default_subject = true)
      subject = if default_subject
                  'You have a new notification'
                else
                  "#{notification.experience.name} is happening soon"
                end
      logger.info "sending email to guest #{guest.id} for " \
                  "notification #{notification.id}"
      NotificationMailer.email(guest_email: guest.email,
                               subject: subject,
                               message: notification.email_body).deliver_later
    end

    def self.logger
      Logger.new(STDOUT)
    end
  end
end
