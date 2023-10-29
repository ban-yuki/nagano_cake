class Admin::ItemsController < ApplicationController
  
  #has_one_attached :image
  
  def new
    @item = Item.new 
  end
  
  def index
    @items = Item.all
  end
  
  def show
  end
  
  def edit
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
  end
  
  def update
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
end
