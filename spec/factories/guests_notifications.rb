# frozen_string_literal: true

FactoryBot.define do
  factory :guests_notification do
    association :guest
    association :notification
  end
end
