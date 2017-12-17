# frozen_string_literal: true

FactoryBot.define do
  factory :users_event do
    association :user
    association :event
  end
end
