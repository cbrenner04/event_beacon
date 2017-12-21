# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.3'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'gretel', '~> 3.0', '>= 3.0.9'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'simplecov', '~> 0.15.1'
gem 'turbolinks', '~> 5'
gem 'twilio-ruby', '~> 5.6'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.16', '>= 2.16.1'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'poltergeist', '~> 1.17'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-erd', '~> 1.5', '>= 1.5.2'
  gem 'rubocop', '~> 0.51.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

ruby '2.4.1'
