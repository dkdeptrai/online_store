# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id         :bigint           not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_images_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
require 'minitest/autorun'
require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def setup
    @product = products(:valid_product1)
    assert @product.present?, 'Product should be present for the test.'
  end

  def new_image(url)
    Image.new(url:, product: @product)
  end

  test 'image url must not be empty' do
    image = Image.new
    assert image.invalid?
    assert image.errors[:url].any?
    assert image.errors[:product_id].any?
  end

  test 'image url must be a URL for GIF, JPG, JPEG, PNG, or WEBP image' do
    ok = %w[https://foo.jpg https://foo.png https://foo.webp https://foo.jpeg]
    bad = %w[https://foo.doc https://foo.gif/more https://foo.gif.more]

    ok.each do |f|
      image = new_image(f)

      assert image.valid?, " #{f} should be valid"
    end

    bad.each do |f|
      image = new_image(f)
      assert image.invalid?, "#{f} should not be valid"
    end
  end

  test 'product is not valid without a unique name' do
    product = Product.new(name: products(:valid_product1).name, description: 'yyy', price: 1,
                          category: categories(:kids_category), brand: brands(:nike_brand), heel_height: '5 cm')

    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:name]
  end
end
