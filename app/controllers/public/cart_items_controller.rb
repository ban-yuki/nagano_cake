class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @item = Item.all
    @total = @cart_items.inject(0) { + cart_item.subtotal }
  end

  def create
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id=current_customer.id
      if @cart_item.save
        redirect_to cart_items_path
      else
        render :new
      end
    end
    
      @cart_item.customer_id=current_customer.id
      if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
        cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.quantity += params[:cart_item][:quantity].to_i
        cart_item.save
        flash[:notice] = 'カートに商品が入りました。'
        redirect_to cart_items_path
      else
        @cart_item.quantity += params[:cart_item][:quantity].to_i
        if @cart_item.save
          flash[:notice] = 'カートに商品が入りました。'
          redirect_to cart_items_path
        else
          flash[:alert] = '商品の追加に失敗しました。'
          redirect_to item_path
        end
  
    end
  end

  def update
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
		@cart_item.update(cart_item_params)
		redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
  　render 'index'
  end

  def destroy_all
    @cart_items = CartItems.all
    current_customer.cart_items.destroy_all
  　render 'index'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity, :customer_id)
  end

end
