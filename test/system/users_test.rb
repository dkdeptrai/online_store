# frozen_string_literal: true

require 'application_system_test_case'
require 'test_helper'

class UsersTest < ApplicationSystemTestCase
  setup do
    login_as users(:one)
  end

  test 'visiting the orders index' do
    click_on 'Orders'

    assert_selector 'h1', text: 'Orders'
  end

  test 'visiting the users index' do
    click_on 'Users'

    assert_selector 'h1', text: 'Users'
  end

  test 'redirecting to the login page if access to sensitive data without permission' do
    logout
    visit orders_url

    assert_selector 'h2', text: 'Please Log In'
  end
end
