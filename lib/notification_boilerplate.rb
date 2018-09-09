# frozen_string_literal: true

# boilerplate for messaging
module NotificationBoilerplate
  def self.sms_boilerplate
    'You can reply STOP at any time to discontinue notifications.'
  end

  def self.email_boilerplate
    'You can follow the UNSUBSCRIBE links at the bottom of the email at any ' \
    'time to discontinue notifications.'
  end
end
