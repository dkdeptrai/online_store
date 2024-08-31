# frozen_string_literal: true

LineItem.destroy_all
Cart.destroy_all
SupportRequest.destroy_all
Order.destroy_all
Image.destroy_all
Product.destroy_all
Category.destroy_all
Brand.destroy_all

Category.create!(name: 'Category 1')
Brand.create!(name: 'Brand 1')

# product = Product.create!(name: 'Product 1', code: 'P1', price: 100, category: Category.first, brand: Brand.first, description: %(<p>
# <em>Robust, Reliable, and Resilient</em> APIs are transforming the business world at an increasing pace. Gain the essential skills needed to quickly design, build, and deploy quality web APIs that are robust, reliable, and resilient. Go from initial design through prototyping and implementation to deployment of mission-critical APIs for your organization. Test, secure, and deploy your API with confidence and avoid the “release into production” panic. Tackle just about any API challenge with more than a dozen open-source utilities and common programming patterns you can apply right away.
# ))
# product.images.create!(url: 'https://res.cloudinary.com/ddcoits0u/image/upload/v1721666041/qspepyoact1gtbm5px7a.jpg')

User.create(name: 'dave', password: Rails.application.credentials.dave_password)

# generates 50 random products
50.times do |i|
  product = Product.create!(
    name: Faker::Commerce.product_name,
    code: Faker::Code.asin + i.to_s,
    price: Faker::Commerce.price(range: 100.0..400.0),
    category: Category.first,
    brand: Brand.first,
    description: Faker::Lorem.paragraph(sentence_count: 10)
  )
  product.images.create!(url: Faker::LoremFlickr.image(size: '300x300', search_terms: ['cats']))
  puts "Product #{i} created"
end
