  ENV['RAILS_ENV'] ||= 'test'

  require 'spec_helper'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'simple_bdd'
  require 'shoulda/matchers'
  require 'pundit/rspec'
  require 'capybara/email/rspec'

  Capybara.javascript_driver = :webkit

  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, type: :feature) do
      # :rack_test driver's Rack app under test shares database connection
      # with the specs, so continue to use transaction strategy for speed.
      driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

      if !driver_shares_db_connection_with_specs
        # Driver is probably for an external browser with an app
        # under test that does *not* share a database connection with the
        # specs, so use truncation strategy.
        DatabaseCleaner.strategy = :truncation
      end
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.append_after(:each) do
      DatabaseCleaner.clean
    end

    config.include SimpleBdd, type: :feature

    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end

    # simplified FactoryGirl Syntax
    config.include FactoryGirl::Syntax::Methods

    config.infer_spec_type_from_file_location!

    config.filter_rails_from_backtrace!

  end
