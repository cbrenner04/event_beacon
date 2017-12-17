# frozen_string_literal: true

FactoryBot.define do
  factory :guest do
    first_name 'MyString'
    last_name 'MyString'
    email 'MyString'
    phone_number 'MyString'
    notification_category nil
    event
  end
end
