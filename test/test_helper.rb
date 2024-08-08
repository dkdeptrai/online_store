# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'capybara/dsl'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    # fixtures :brands
    # fixtures :categories
    # fixtures :products
    # fixtures :images
    # fixtures :pay_types
    # fixtures :carts
    # fixtures :line_items
    # fixtures :orders
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module AuthenticationHelpers
  def login_as(user)
    if respond_to? :visit
      visit login_path
      fill_in :name, with: user.name
      fill_in :password, with: 'secret'
      click_on 'Login'
    else
      post login_path, params: { name: user.name, password: 'secret' }
    end
  end

  def logout
    current_driver = Capybara.current_driver
    Capybara.current_driver = :rack_test
    page.driver.delete logout_path
    Capybara.current_driver = current_driver
  end

  def setup
    login_as users(:one)
  end
end

module ActionDispatch
  class IntegrationTest
    include AuthenticationHelpers
  end
end

module ActionDispatch
  class SystemTestCase
    include AuthenticationHelpers
  end
end
