# frozen_string_literal: true

FactoryBot.define do
  factory :guest do
    first_name 'Foo'
    last_name 'Bar'
    sequence(:email) { |n| "foo#{n}@bar.com" }
    sequence(:phone_number) { |n| "123#{n}" }
    notification_category nil
    event
  end
end
