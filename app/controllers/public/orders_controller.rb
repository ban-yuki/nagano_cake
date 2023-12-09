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
    @order = @item.order.new(order_params)
    @order.save
    redirect_to items_path  
  end
  
  private
  
  def order_params
    params.require(:order).permit(:quantity, :item_id)
  end 
end

 