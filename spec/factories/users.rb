# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password 'foobar!'
    password_confirmation 'foobar!'
  end
end
