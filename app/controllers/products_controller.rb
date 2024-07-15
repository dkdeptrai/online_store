# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_collections
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      if params[:product][:images].present?
        images = Array(params[:product][:images])
        images.each do |image|
          @product.images.attach(image)
          # @product.images.create(url: @product.images.last.key)
        end
      end
      redirect_to new_product_path, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @product.images.build if @product.images.empty?
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      if params[:product][:images].present?
        images = Array(params[:product][:images])
        images.each do |image|
          @product.images.attach(image)
          # @product.images.create(url: @product.images.last.key)
        end
      end
      redirect_to product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to product_params, notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :code, :price, :category_id, :brand_id, :heel_height, :description,
                                    images: [])
  end

  def set_collections
    @brands = Brand.all
    @categories = Category.all
  end
end
