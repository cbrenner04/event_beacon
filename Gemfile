# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'aes', '~> 0.5.0'
gem 'attr_encrypted', '~> 3.1'
gem 'bitly', '~> 1.1', '>= 1.1.1'
gem 'bootstrap', '~> 4.0'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.3'
gem 'gretel', '~> 3.0', '>= 3.0.9'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'pg', '~> 1.0'
gem 'puma', '~> 3.11', '>= 3.11.3'
gem 'rails', '~> 5.1', '>= 5.1.6'
gem 'redcarpet', '~> 3.4'
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
gem 'simplecov', '~> 0.16.1'
gem 'turbolinks', '~> 5.1'
gem 'twilio-ruby', '~> 5.7', '>= 5.7.2'
gem 'uglifier', '~> 4.1', '>= 4.1.8'

group :development, :test do
  gem 'bundler-audit', '~> 0.6.0'
  gem 'byebug', '~> 10.0', '>= 10.0.2', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.18'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'faker', '~> 1.8', '>= 1.8.7'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'poltergeist', '~> 1.17'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'site_prism', '~> 2.11'
end

group :development do
  gem 'listen', '~> 3.1', '>= 3.1.5'
  gem 'rails-erd', '~> 1.5', '>= 1.5.2'
  gem 'rubocop', '~> 0.54.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
  gem 'web-console', '~> 3.5', '>= 3.5.1'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

ruby '2.4.1'
