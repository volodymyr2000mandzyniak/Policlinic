# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.1.2"

# Core Rails gems
gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem 'rake'

gem 'nokogiri', '< 1.16.0'

# Frontend
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "bootstrap"
gem "sassc-rails"
gem "jbuilder"

# Authentication & Authorization
gem "devise"
gem "activeadmin"
gem "cancancan"

# Media processing
gem "image_processing"

# Platform-specific gems
gem "tzinfo-data", platforms: %i[windows jruby]

# Development and test environment
group :development, :test do
  # Environment management
  gem "dotenv-rails"
  
  # Debugging
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  
  # Code quality
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  
  # Testing
  gem "rspec-rails", "~> 6.1"
  gem "rails-controller-testing"
  gem "factory_bot_rails"
  gem "faker"
end

# Development-only gems
group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

# Test-only gems
group :test do
  # Browser testing
  gem "capybara"
  gem "selenium-webdriver"
  
  # Test utilities
  gem "shoulda-matchers", "~> 6.0"
  gem "webmock"
  gem "vcr"
  
  # Test coverage
  gem "simplecov", require: false
  
  # Database cleaning
  gem "database_cleaner-active_record"
end

# Production gems
group :production do
  gem "pg", "~> 1.1"
  gem "rails_12factor"
end