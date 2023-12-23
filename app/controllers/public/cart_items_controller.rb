class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @cart_item = current_customer.cart_items.find_by(quantity: params[:quantity])
    @item = Item.all
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }

  end

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.quantity += params[:cart_item][:quantity].to_i
      @cart_item.save
        flash[:notice] = 'カートに商品が入りました。'
        redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id=current_customer.id
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
		redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
  　render 'index'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity, :customer_id)
  end

end
