# frozen_string_literal: true

class OrdersController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_is_not_empty, only: %i[new create]
  before_action :set_order, only: %i[show edit update destroy]
  before_action :set_pay_types, only: %i[new create edit update]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        Rails.logger.info("Pay type params: #{pay_type_params.to_h}")
        ChargeOrderJob.perform_later(@order, pay_type_params.to_h)

        format.html do
          redirect_to store_index_path,
                      notice: 'Order was successfully created. Thank you for your order.'
        end
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type_id, :credit_card_number, :expiration_date,
                                  :purchase_order_number, :routing_number, :account_number)
  end

  def pay_type_params
    pay_type = PayType.find(order_params[:pay_type_id]).name

    case pay_type
    when 'Check'
      params.require(:order).permit(:routing_number, :account_number)
    when 'Credit Card'
      params.require(:order).permit(:credit_card_number, :expiration_date)
    when 'Purchase Order'
      params.require(:order).permit(:purchase_order_number)
    end
  end

  def ensure_cart_is_not_empty
    return unless @cart.line_items.empty?

    redirect_to store_index_path, notice: 'Your cart is empty'
  end

  def set_pay_types
    @pay_types = PayType.all.each_with_object({}) do |pay_type, hash|
      hash[pay_type.name] = pay_type.id
    end
  end
end
