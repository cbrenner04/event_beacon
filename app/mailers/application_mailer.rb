# frozen_string_literal: true

# no doc
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@brennoranotifier.herokuapp.com'
  layout 'mailer'
end
