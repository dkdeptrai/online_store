# frozen_string_literal: true

require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item_with_1_quantity = line_items(:one)
    @line_item_with_2_quantity = line_items(:two)
    @product = products(:valid_product1)
  end

  test 'should get index' do
    get line_items_url
    assert_response :success
  end

  test 'should get new' do
    get new_line_item_url
    assert_response :success
  end

  test 'should create line_item' do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: @line_item_with_1_quantity.product_id }

      follow_redirect!

      assert_select 'h2', 'Your Products Cart'
      assert_select 'td', 'Valid Product 1'
    end
  end

  test 'should show line_item' do
    get line_item_url(@line_item_with_1_quantity)
    assert_response :success
  end

  test 'should get edit' do
    get edit_line_item_url(@line_item_with_1_quantity)
    assert_response :success
  end

  test 'should update line_item' do
    patch line_item_url(@line_item_with_1_quantity,
                        params: { line_item: { product_id: @line_item_with_1_quantity.product_id } })
    assert_redirected_to line_item_url(@line_item_with_1_quantity)
  end

  test 'should destroy line_item' do
    assert_difference('LineItem.count', -1) do
      delete line_item_url(@line_item_with_1_quantity)
    end

    assert_redirected_to store_index_path
  end

  test 'should create line_item via turbo-stream' do
    assert_difference('LineItem.count') do
      post line_items_path, params: { product_id: @product.id }, as: :turbo_stream
    end

    assert_response :success

    assert_match(/<tr class="line-item-highlight">/, @response.body)
  end

  test 'should decrease quantity' do
    assert_difference('@line_item_with_2_quantity.reload.quantity', -1) do
      patch decrease_quantity_line_item_path(@line_item_with_2_quantity)
    end

    assert_redirected_to store_index_path
  end

  test 'should delete line_item if quantity is zero after decrement' do
    assert_difference('LineItem.count', -1) do
      patch decrease_quantity_line_item_path(@line_item_with_1_quantity)
    end

    assert_redirected_to store_index_path
  end
end
