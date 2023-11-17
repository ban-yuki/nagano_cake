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
    @order = Order.find(params[:id])
  end
  
  def confirm_orders
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new(item_params)
    if @order.save 
    redirect_to admin_item_path(@order)
    else
    render :new
    end
  end
end
