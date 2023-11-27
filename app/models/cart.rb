class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :nullify
  has_many :items, through: :cart_items
end
