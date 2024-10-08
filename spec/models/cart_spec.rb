# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Cart, type: :model do
  fixtures :products
  subject(:cart) { Cart.new }

  let(:product_one) { products(:valid_product1) }
  let(:product_two) { products(:valid_product2) }

  describe '#add_product' do
    context 'adding unique products' do
      before do
        cart.add_product(product_one).save!
        cart.add_product(product_two).save!
      end

      it 'has two line items' do
        expect(cart.line_items.size).to eq(2)
      end

      it "has a total price of the two items' price" do
        expect(cart.total_price).to eq(product_one.price + product_two.price)
      end
    end

    context 'adding duplicate products' do
      before do
        cart.add_product(product_one).save!
        cart.add_product(product_one).save!
      end

      it 'has one line item' do
        expect(cart.line_items.size).to eq(1)
      end

      it 'has a line item with a quantity of 2' do
        expect(cart.line_items.first.quantity).to eq(2)
      end

      it "has a total price of twice the product's price" do
        expect(cart.total_price).to eq(2 * product_one.price)
      end
    end
  end
end
