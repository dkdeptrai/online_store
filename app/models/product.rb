# frozen_string_literal: true

# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many_attached :images

  after_save :create_image_records

  validates :name, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :brand_id, presence: true
  validates :description, presence: true

  private

  def create_image_records
    images.each do |attached_image|
      Image.create!(product_id: id, url: Cloudinary::Utils.cloudinary_url(attached_image.key))
    end
  end
end
