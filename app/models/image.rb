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
# app/models/image.rb
class Image < ApplicationRecord
  belongs_to :product

  #  VALID_IMAGE_URL_REGEX = %r{\A(https?://.*\.(gif|jpe?g|png|webp)|https?://loremflickr\.com/.*)\z}i
  VALID_IMAGE_URL_REGEX = %r{\Ahttps?://.*\z}

  validates :url, presence: true
  validates :url, format: {
    with: VALID_IMAGE_URL_REGEX,
    message: 'must be a valid URL for a GIF, JPG, JPEG, PNG, or WEBP image.'
  }
  validates :product_id, presence: true
end
