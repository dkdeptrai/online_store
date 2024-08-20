# frozen_string_literal: true

LineItem.destroy_all
Cart.destroy_all
Order.destroy_all
Image.destroy_all
Product.destroy_all

Category.create!(name: 'Category 1')
Brand.create!(name: 'Brand 1')

product = Product.create!(name: 'Product 1', code: 'P1', price: 100, category: Category.first, brand: Brand.first, heel_height: 1, description: %(<p>
<em>Robust, Reliable, and Resilient</em> APIs are transforming the business world at an increasing pace. Gain the essential skills needed to quickly design, build, and deploy quality web APIs that are robust, reliable, and resilient. Go from initial design through prototyping and implementation to deployment of mission-critical APIs for your organization. Test, secure, and deploy your API with confidence and avoid the “release into production” panic. Tackle just about any API challenge with more than a dozen open-source utilities and common programming patterns you can apply right away.
))
product.images.create!(url: 'https://res.cloudinary.com/ddcoits0u/image/upload/v1721666041/qspepyoact1gtbm5px7a.jpg')

User.create!(name: 'dave', password: Rails.application.credentials.dave_password)
