# frozen_string_literal: true

require 'aes'

FactoryBot.define do
  factory :data_encryption_key do
    key AES.key
    primary true
  end
end
