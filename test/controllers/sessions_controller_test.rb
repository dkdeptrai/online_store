# frozen_string_literal: true

require 'est_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should prompt for login' do
    get login_path
    assert_response :success
  end

  test 'should login' do
    dave = users(:one)
    post login_path, params: { name: dave.name, password: 'secret' }
    assert_redirected_to admin_url
    assert_equal dave.id, session[:user_id]
  end

  test 'should fail login' do
    dave = users(:one)
    post login_path, params: { name: dave.name, password: 'wrong' }
    assert_redirected_to login_path
  end

  test 'should logout' do
    delete logout_path
    assert_nil session[:user_id]
    assert_redirected_to store_index_path
  end
end
