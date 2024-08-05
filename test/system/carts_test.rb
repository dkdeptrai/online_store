# frozen_string_literal: true

require 'application_system_test_case'

class CartsTest < ApplicationSystemTestCase
  test 'adding a product to cart shows the cart' do
    visit store_index_path

    click_on 'Add to Cart', match: :first

    assert has_selector? 'h2', text: 'Your Products Cart'
  end

  test 'emptying the cart hides the cart' do
    visit store_index_path
    click_on 'Add to Cart', match: :first

    assert has_selector? 'h2', text: 'Your Products Cart'

    click_on 'Empty Cart'

    assert has_no_selector? 'h2', text: 'Your Products Cart'
  end

  test 'highlighting a new cart line item' do
    visit store_index_path
    click_on 'Add to Cart', match: :first

    assert page.has_selector?('.line-item-highlight')
  end
end
