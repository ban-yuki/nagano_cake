class Public::OrdersController < ApplicationController
  
   def new
    @order = Order.new
  end

  def index
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
  end

  def confirm
    @item = Item.find(params[:item_id])
    @order = @item.order.new(order_params)
    @confirm = 800
     
    
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
    params.require(:order).permit(:quantity, :item_id)
  end 
end

 