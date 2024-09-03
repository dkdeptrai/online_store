# frozen_string_literal: true

class StoreController < ApplicationController
  include CurrentCart

  skip_before_action :authorize

  before_action :set_cart
  before_action :set_products_from_categories

  def index
    update_counter
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      respond_to do |format|
        format.html
        format.json
      end
    end
  end

  def lazy_load
    @products = Product.all

    render partial: 'store/product', collection: @products, layout: false, cache: true
  end

  private

  def update_counter
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end

  def set_products_from_categories
    @pagy_category1_products, @category1_products = pagy_countless(Category.find_by(name: 'Category 1').products,
                                                                   limit: 5, overflow: :empty_page)
    @pagy_category2_products, @category2_products = pagy_countless(Category.find_by(name: 'Category 2').products,
                                                                   limit: 5, overflow: :empty_page)
    @pagy_category3_products, @category3_products = pagy_countless(Category.find_by(name: 'Category 3').products,
                                                                   limit: 5, overflow: :empty_page)
  end
end
