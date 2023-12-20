class Order < ApplicationRecord

   belongs_to :customer
   has_many :order_details
   has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }


  def address_display
    '〒' + postal_code + ' ' + address
  end
  
  def subtotal
    cart_item.with_tax_price * quantity
  end

end