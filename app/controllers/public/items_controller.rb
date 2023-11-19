class Public::ItemsController < ApplicationController

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = Cart_item.new
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image,)
  end

end
