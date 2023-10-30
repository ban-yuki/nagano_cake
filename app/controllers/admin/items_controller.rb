class Admin::ItemsController < ApplicationController

  #has_one_attached :image

  def new
    @item = Item.new
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def create
    @item = Item.new(item_params[:item])
    @item.save
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
end
