class OrderItem < ApplicationRecord
  attribute_default :quantity, -> { 1 }
  belongs_to :order
  belongs_to :item
end
