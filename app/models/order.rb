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
#  ship_date             :datetime
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

require 'active_model/serializers/json'
require 'pago'

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :pay_type

  validates :name, :address, :email, presence: true
  validates :pay_type_id, presence: true
  validates :account_number, :routing_number, presence: true, if: -> { pay_type&.name == 'Check' }
  validates :credit_card_number, :expiration_date, presence: true, if: -> { pay_type&.name == 'Credit card' }
  validates :purchase_order_number, presence: true, if: -> { pay_type&.name == 'Purchase order' }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def charge!(pay_type_params)
    Rails.logger.info("Charging order #{id}")
    payment_details = {}
    payment_method = nil
    case pay_type.name
    when 'Check'
      payment_method = :check
      payment_details[:routing_number] = pay_type_params[:routing_number]
      payment_details[:account_number] = pay_type_params[:account_number]
    when 'Credit Card'
      payment_method = :credit_card
      month, year = pay_type_params[:expiration_date].split('/')
      payment_details[:credit_card_number] = pay_type_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when 'Purchase Order'
      payment_method = :purchase_order
      payment_details[:purchase_order_number] = pay_type_params[:purchase_order_number]
    end

    payment_result = Pago.make_payment(order_id: id, payment_method:, payment_details:)

    raise payment_result.error unless payment_result.succeeded?

    OrderMailer.received(self).deliver_later
  end

  def notify_shipped
    OrderMailer.shipped(self).deliver_later
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
