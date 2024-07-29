# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_collections, only: %i[new edit create update]
  before_action :set_product, only: %i[show edit update destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params.except(:images))

    if @product.save
      if params[:product][:images].present?
        images = params[:product][:images]
        process_images(images)
      end
      redirect_to product_path(@product), notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @products = Product.all.reverse
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product.images.build if @product.images.empty?
  end

  def update
    if @product.update(product_params.except(:images))
      if params[:product][:images].present?
        @product.images.destroy_all
        images = params[:product][:images]
        process_images(images)
      end
      redirect_to product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully destroyed.'
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

  def set_product
    @product = Product.find(params[:id])
  end

  def process_images(images)
    filtered_image = images.compact
    filtered_image.each do |image|
      img_url = ImageUploader.upload(image, @product.id)
      @product.images.create!(url: img_url)
    rescue StandardError => e
      Rails.logger.debug("Error uploading image: #{e.message}")
    end
  end
end
