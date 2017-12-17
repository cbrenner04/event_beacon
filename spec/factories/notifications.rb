# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    sms_body 'MyText'
    email_body 'MyText'
    experience
  end
end
