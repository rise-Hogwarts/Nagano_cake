class OrderDetail < ApplicationRecord
  enum production_status: {before: 0, waiting: 1, making: 2, finish:3}

  belongs_to :order
  belongs_to :item
end
