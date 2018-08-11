# frozen_string_literal: true

FactoryBot.define do
  factory :encrypted_field do
    blob 'MyString'
    data_encryption_key
  end
end
