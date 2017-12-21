# frozen_string_literal: true

require 'sms_notifier'

module Tasks
  # sends notification to guests
  class Notifier
    def self.send_notifications
      notifications = Notification.all
      notifications.each do |notification|
        next unless notification.experience.needs_notifying?
        notification.guests.each do |guest|
          nc = guest.notification_category
          next if nc.nil?
          send_sms_for(guest, notification) if %w[text both].include? nc
          send_email_for(guest, notification) if %w[email both].include? nc
        end
      end
    end

    def self.send_sms_for(guest, notification)
      logger.info "sending sms to guest #{guest.id} for " \
                  "notification #{notification.id}"
      SmsNotifier.send_sms(number: guest.phone_number,
                           message: notification.sms_body)
    end

    def self.send_email_for(guest, notification)
      logger.info "sending email to guest #{guest.id} for " \
                  "notification #{notification.id}"
      NotificationMailer.email(
        guest_email: guest.email,
        subject: "#{notification.experience.name} is happening soon",
        message: notification.email_body
      ).deliver_now
    end

    def self.logger
      Logger.new(STDOUT)
    end
  end
end
