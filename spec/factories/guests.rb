# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :guest do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { Faker::Internet.safe_email }
    sequence(:phone_number) { |n| "123456#{n}" }
    notification_category nil
    event
  end
end
