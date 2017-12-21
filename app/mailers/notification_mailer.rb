# frozen_string_literal: true

# sends email notifications to guests
class NotificationMailer < ApplicationMailer
  def email(guest_email:, subject:, message:)
    @message = message
    mail(to: guest_email, subject: subject)
  end
end
