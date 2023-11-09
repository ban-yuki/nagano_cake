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
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to admin_item_path(@item)
    else
    render :new
    end
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
end
