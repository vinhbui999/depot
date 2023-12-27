# frozen_string_literal: true

class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_order, only: %i[show edit update destroy]
  before_action :set_cart, only: %i[new create]
  before_action :ensure_cart_isnt_empty, only: [:new]
  before_action :authorize, only: %i[index edit destroy update]
  before_action :user_owner, only: %i[new create]
  before_action :order_index, only: :new
  before_action :list_products, only: %i[show]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = @user_owner.orders.build(Order.new.attributes)
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = @user_owner.orders.build(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.cart_id = @cart.id
    @order.ship_date = Time.now.to_s(:db)
    if @order.save
      @cart.update(order_id: @order.id)
      session[:cart_id] = nil
      OrderMailer.received(@order).deliver_later
      redirect_to store_index_path, notice: t('.thanks')
    else
      redirect_to new_order_url
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        OrderMailer.shipped(@order).deliver_later
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @cart = Cart.find(@order.cart_id)
    @order.destroy
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
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def ensure_cart_isnt_empty
    return unless @cart.line_items.empty?

    redirect_to store_index_url, notice: 'Your cart is empty'
  end

  def user_owner
    @user_owner = User.find(session[:user_id])
  end

  def order_index
    @index = @user_owner.orders.last.nil? ? '1' : (@user_owner.orders.last.name.to_i + 1).to_s
  end

  def list_products
    @line_items = LineItem.where(order_id: @order.id, cart_id: @order.cart_id)
    logger.debug("List items #{@line_items.ids}")
  end
end
