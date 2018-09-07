# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name 'MyString'
    occurs_at '2017-12-16 21:34:00'
    organizer 'MyString'
    nickname 'MyString'
    welcome_sms 'MyText'
    welcome_email 'MyText'
  end
end
