# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :guest do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { Faker::Internet.safe_email }
    sequence(:phone_number) do |n|
      number = "123456#{n}"[0..9]
      diff = 10 - number.length
      diff.times { number += '0' }
      number
    end
    notification_category 'both'
    event
    welcome_email_sent_at Time.zone.now
    welcome_sms_sent_at Time.zone.now
  end
end
