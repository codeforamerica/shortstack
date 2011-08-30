require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  SimpleCov.start
  require 'webmock/rspec'
  require 'sunspot/rails/spec_helper'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec
    config.include WebMock::API
    config.fixture_path = "#{::Rails.root}/spec/factories"

    config.before(:each) do
        ::Sunspot.session = ::Sunspot::Rails::StubSessionProxy.new(::Sunspot.session)
      end

    config.after(:each) do
      ::Sunspot.session = ::Sunspot.session.original_session
    end

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
    include Devise::TestHelpers
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.
  require 'factory_girl_rails'
  require 'simplecov'
  SimpleCov.start do
    add_group "Models", "app/models"
    add_group "Controllers", "app/controllers"
  end

end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
