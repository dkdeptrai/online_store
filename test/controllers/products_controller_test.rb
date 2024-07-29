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
        post products_path, params: {
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
    assert_redirected_to product_path(Product.last)
  end

  test 'should create product with 2 associated images' do
    assert_difference('Product.count') do
      assert_difference('Image.count', 2) do
        post products_path, params: {
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
    assert_redirected_to product_path(Product.last)
  end

  test 'should update product' do
    patch product_path(@product), params: {
      product: {
        name: @name,
        description: @product.description,
        price: @product.price,
        brand_id: @product.brand_id,
        category_id: @product.category_id,
        heel_height: @product.heel_height
      }
    }

    assert_redirected_to product_path(@product)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_path(@product)
    end

    assert_redirected_to products_path
  end

  test 'must not destroy product in cart' do
    assert_no_difference('Product.count') do
      delete product_path(products(:valid_product1))
    end

    assert_redirected_to products_path
  end
end
