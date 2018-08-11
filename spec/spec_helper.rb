# frozen_string_literal: true

require 'mock_sms_notifier'
require 'mock_bitly'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    dek = DataEncryptionKey.generate!
    dek.promote!
    stub_const('SmsNotifier', MockSmsNotifier)
    stub_const('Bitly', MockBitly)
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
