# frozen_string_literal: true

class AddPaymentParemetersToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :routing_number, :string
    add_column :orders, :account_number, :string
    add_column :orders, :credit_card_number, :string
    add_column :orders, :expiration_date, :string
    add_column :orders, :purchase_order_number, :string
  end
end
