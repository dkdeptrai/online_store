# frozen_string_literal: true

class StoreController < ApplicationController
  def index
    @products = Product.order(:name)
  end
end
