class Item < ApplicationRecord
    has_many :order_items, dependent: :nullify
    has_many :cart_items, dependent: :nullify
end
