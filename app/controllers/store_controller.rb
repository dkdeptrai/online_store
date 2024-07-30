# frozen_string_literal: true

class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    update_counter

    @products = Product.order(:name)
  end

  private

  def update_counter
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end
end
