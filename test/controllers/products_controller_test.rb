# frozen_string_literal: true

require 'minitest/autorun'
require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:valid_product1)
    @image = images(:valid_image1)
    @name = "The Great Product #{rand(1000)}"
  end

  test 'should create product with 1 associated image' do
    assert_difference('Product.count') do
      assert_difference('Image.count') do
        post products_url, params: {
          product: {
            name: @name,
            description: @product.description,
            price: @product.price,
            brand_id: @product.brand_id,
            category_id: @product.category_id,
            heel_height: @product.heel_height,
            images: [fixture_file_upload('test.jpeg')]
          }
        }
      end
    end
    assert_redirected_to product_url(Product.last)
  end

  test 'should create product with 2 associated images' do
    assert_difference('Product.count') do
      assert_difference('Image.count', 2) do
        post products_url, params: {
          product: {
            name: @name,
            description: @product.description,
            price: @product.price,
            brand_id: @product.brand_id,
            category_id: @product.category_id,
            heel_height: @product.heel_height,
            images: [fixture_file_upload('test.jpeg'), fixture_file_upload('test.jpeg')]
          }
        }
      end
    end
    assert_redirected_to product_url(Product.last)
  end

  test 'should update product' do
    patch product_url(@product), params: {
      product: {
        name: @name,
        description: @product.description,
        price: @product.price,
        brand_id: @product.brand_id,
        category_id: @product.category_id,
        heel_height: @product.heel_height
      }
    }

    assert_redirected_to product_url(@product)
  end
end
