class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :items
  
  def subtotal
    item.with_tax_price * amount
  end

end
