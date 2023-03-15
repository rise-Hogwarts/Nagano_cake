class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { before: 0, confirm: 1, making: 2, before_sending: 3, sent: 4}
  belongs_to :customer
  has_many :order_details
end
