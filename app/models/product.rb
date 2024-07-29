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
# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :images, dependent: :destroy
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category_id, presence: true
  validates :brand_id, presence: true
  validates :description, presence: true
  validates :heel_height, presence: true

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
