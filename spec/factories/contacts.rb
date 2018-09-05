# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    subject 'MyString'
    body 'MyText'
    user
  end
end
