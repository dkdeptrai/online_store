# frozen_string_literal: true

class StoreController < ApplicationController
  include CurrentCart

  skip_before_action :authorize

  before_action :set_cart

  def index
    update_counter
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:name)
    end
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
