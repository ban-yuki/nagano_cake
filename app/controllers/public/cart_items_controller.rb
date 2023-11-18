class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = CartItem.all
    @item = Item.find(params[:id])
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_items=current_customer.cart_items.all
      @cart_items.each do |cart_item|
        if cart_item.item_id==@cart_item.item_id
        new_quantity = cart_item.quantity + @cart_item.quantity
        cart_item.update_attribute(:quantity, new_quantity)
        @cart_item.delete
        end
      end
      @cart_item.save
      redirect_to cart_items_path,notice:"カートに商品が入りました"
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
    redirect_to admin_items_path(@cart_item)
    else
    @cart_item = CartItem.all
    render :edit
    end
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
  　render 'index'
  end
  
  def destroy_all
    @cart_items = CartItems
    cart_items = CartItem.all
    cart_items.destroy_all
  　render 'index'
  end

  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
