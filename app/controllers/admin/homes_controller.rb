class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.all
    @cart_items = CartItem.where(order_id: @orders.pluck(:id))
    # @cart_items.each do |cart_item|
    #   puts cart_item.quantity
    #end
  end
end
