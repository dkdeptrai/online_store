# frozen_string_literal: true

require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
    @product = products(:valid_product1)

    puts "setup line_items: #{@cart.line_items.first.product.name}"
  end

  test 'should get index' do
    get carts_url
    assert_response :success
  end

  test 'should get new' do
    get new_cart_url
    assert_response :success
  end

  test 'should create cart' do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {} }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test 'should show cart' do
    get cart_url(@cart)

    assert_redirected_to store_index_path
  end

  test 'should get edit' do
    get edit_cart_url(@cart)
    assert_response :success
  end

  test 'should update cart' do
    patch cart_url(@cart), params: { cart: {} }
    assert_redirected_to cart_url(@cart)
  end

  # test 'should destroy cart' do
  #   session = open_session do |sess|
  #     sess.post line_items_url, params: { product_id: @product.id }
  #     sess.session[:cart_id] = @cart.id
  #   end
  #
  #   @cart.reload
  #
  #   assert_equal @cart.id, session[:cart_id]
  #
  #   puts "@cart id: #{@cart.id}"
  #   puts "session cart: #{session[:cart_id]}"
  #   puts "Cart items: #{@cart.line_items.first.product.name}"
  #
  #   assert_difference('Cart.count', -1) do
  #     session.delete cart_path(@cart)
  #   end
  #
  #   assert_redirected_to store_index_path
  # end
end
