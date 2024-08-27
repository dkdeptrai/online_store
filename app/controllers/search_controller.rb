class SearchController < ApplicationController
  skip_before_action :authorize

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end
