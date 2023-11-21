class Public::ItemsController < ApplicationController

  def index
    @item = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = Cart_item.new
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :id)
  end

end
