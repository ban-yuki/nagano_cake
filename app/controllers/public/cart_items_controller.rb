class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = Cart_item.all
  end

  def create
    @cart_item = Cart_item.new(cart_item_params)
    if @cart_item.save 
    redirect_to admin_item_path(@cart_item)
    else
    render :new
    end
  end

  def update
    @cart_item = Cart_item.find(params[:id])
    if @cart_item.update(cart_item_params)
    redirect_to admin_items_path(@cart_item)
    else
    @cart_item = Cart_item.all
    render :edit
    end
  end
  
  def destroy
    @cart_item = Cart_item.find(params[:id])
  end
  
  def destroy_all
    @cart_items = Cart_items
  end

  private

end
