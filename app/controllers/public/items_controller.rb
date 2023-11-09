class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.all.order(created_at: :desc)
  end
  
  def show
    @item = Item.find(params[:id])  
  end
  
end
