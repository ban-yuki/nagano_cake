class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.all
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :customer_id, :item_id)
  end

end
