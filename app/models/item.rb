class Item < ApplicationRecord

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  #validates :image
  
  belongs_to :admin
  
  has_one_attached :image

end
