# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                    :bigint           not null, primary key
#  account_number        :string
#  address               :text
#  credit_card_number    :string
#  email                 :string
#  expiration_date       :string
#  name                  :string
#  purchase_order_number :string
#  routing_number        :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  pay_type_id           :bigint
#
# Indexes
#
#  index_orders_on_pay_type_id  (pay_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (pay_type_id => pay_types.id)
#
class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type

  validates :name, :address, :email, presence: true
  validates :pay_type_id, presence: true
  validates :account_number, :routing_number, presence: true, if: -> { pay_type.name == 'Check' }
  validates :credit_card_number, :expiration_date, presence: true, if: -> { pay_type.name == 'Credit card' }
  validates :purchase_order_number, presence: true, if: -> { pay_type.name == 'Purchase order' }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
