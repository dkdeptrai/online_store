# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @cart = Cart.create
    @product_one = products(:valid_product1)
    @product_two = products(:valid_product2)
  end

  test 'add unique products' do
    @cart.add_product(@product_one).save!
    @cart.add_product(@product_two).save!
    assert_equal 2, @cart.line_items.size
  end

  test 'add duplicate product' do
    @cart.add_product(@product_one).save!
    @cart.add_product(@product_one).save!
    assert_equal 1, @cart.line_items.size
    assert_equal 2, @cart.line_items.first.quantity
  end
end
