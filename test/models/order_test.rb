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
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
