# frozen_string_literal: true

# sends email notifications to guests
class NotificationMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)

  def email(guest_email:, subject:, message:)
    @message = message
    mail(to: guest_email, subject: subject)
  end
end
