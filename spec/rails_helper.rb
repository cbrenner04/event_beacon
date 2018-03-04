# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails'
SimpleCov.minimum_coverage 90
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment's running in production!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'site_prism'
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end
include Warden::Test::Helpers
Warden.test_mode!
ActiveRecord::Migration.maintain_test_schema!
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include AuthenticationHelpers, type: :feature
  config.include WaitHelpers, type: :feature
end
