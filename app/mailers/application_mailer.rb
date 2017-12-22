# frozen_string_literal: true

# no doc
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@notifier.site'
  layout 'mailer'
end
