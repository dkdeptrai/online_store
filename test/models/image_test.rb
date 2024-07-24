# frozen_string_literal: true

class ImageTest < ActiveSupport::TestCase

	def setup
		@product = Product.first
		assert @product.present?, 'Product should be present for the test.'
	end

	def new_image(url)
		image = Image.new(url:, product: @product)
		image
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
end
