# frozen_string_literal: true

# app/models/image.rb
class Image < ApplicationRecord
  belongs_to :product

  validates :url, presence: true

end
