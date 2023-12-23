class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = current_customer.orders
    @customer = current_customer
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0

  end

  def confirm
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.destination_name = current_customer.last_name + current_customer.first_name
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.total_payment = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    @order.postage = 800
    @total = 0
    p @order
  end

  def confirm_orders

  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    cart_items.each do |cart|
      @order.total_payment = cart.subtotal + @order.total_payment
    end
     @order.payment_method = params[:order][:payment_method]

    @order.save
      cart_items.each do |cart|
        @order_details = OrderDetail.new
        @order_details.item_id = cart.item.id
        @order_details.order_id = @order.id
        @order_details.order_quantity = cart.quantity
        @order_details.price = cart.item.with_tax_price
        @order_details.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_confirm_orders_path

  end

  private

  def order_params
    params.require(:order).permit(:item_id, :customer_id, :postage, :total_payment, :payment_method, :postal_code, :address, :destination_name)
  end

  def order_address(order)
    current_customer.address
  end


end

