# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.1.2"

gem "rails", "~> 7.2.2", ">= 7.2.2.1"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "rake"

gem "nokogiri", "< 1.16.0"
gem "ffi", "< 1.17.0"

gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "bootstrap"
gem "sassc-rails"
gem "jbuilder"
gem "aws-sdk-s3"

gem "devise"
gem "activeadmin"
gem "cancancan"

gem "image_processing"

gem "tzinfo-data", platforms: %i[windows jruby]

gem "faker"

group :development, :test do
  gem "dotenv-rails"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 6.1"
  gem "rails-controller-testing"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [ :ruby ]
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"

  gem "shoulda-matchers", "~> 6.0"
  gem "webmock"
  gem "vcr"

  gem "simplecov", require: false

  gem "database_cleaner-active_record"
end

group :production do
  gem "pg", "~> 1.1"
  gem "rails_12factor"
end
