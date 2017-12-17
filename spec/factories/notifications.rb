# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    sms_body 'Fake sms body'
    email_body 'Fake email body'
    experience
  end
end
