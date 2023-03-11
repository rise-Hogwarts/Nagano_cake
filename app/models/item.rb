class Item < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, inclusion: { in: [true, false] }




  belongs_to :genre
  has_many :order_details
  has_many :cart_items
  has_one_attached :image


  def with_tax_price
    (price * 1.1).floor
  end
end
