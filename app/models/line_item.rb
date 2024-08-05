# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id          :bigint           not null, primary key
#  quantity    :integer          default(1)
#  total_price :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cart_id     :integer
#  order_id    :bigint
#  product_id  :bigint           not null
#
# Indexes
#
#  index_line_items_on_cart_id     (cart_id)
#  index_line_items_on_order_id    (order_id)
#  index_line_items_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  before_save do
    self.total_price = total_price
  end

  def total_price
    product.price * quantity
  end
end
