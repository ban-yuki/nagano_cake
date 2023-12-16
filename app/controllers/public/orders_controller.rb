class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
    @order_item = @order.order_items
  end

  def confirm    
    params[:order][:payment_method] = params[:order][:payment_method].to_i
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.destination_name = current_customer.last_name + current_customer.first_name 
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.postage = 800 
    @total = 0
  end
  
  def confirm_orders
    @order = Order.find(params[:id])
  end
  
  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_quantity = cart.quantity
        order_item.order_price = cart.item.price
        order_item.save
      end
      redirect_to orders_confirm_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:item_id, :customer_id, :postage, :total_payment, :payment_method, :postal_code, :address, :destination_name)
  end
  
end

 