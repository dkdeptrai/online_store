# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :text
#  heel_height :string
#  name        :string
#  price       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  brand_id    :bigint           not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#  fk_rails_...  (category_id => categories.id)
#
require 'minitest/autorun'

class ProductTest < ActiveSupport::TestCase
  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:brand_id].any?
    assert product.errors[:category_id].any?
    assert product.errors[:heel_height].any?
  end

  test 'product price must be positive' do
    product = Product.new(name: 'Random Shoes', code: 'xxx', description: 'yyy', heel_height: '5 cm', brand: Brand.first,
                          category: Category.first)
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than 0'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than 0'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end
end
