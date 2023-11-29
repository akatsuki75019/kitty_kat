class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :nullify
  has_many :items, through: :cart_items

  def add_item(item)
    # Vérifie si un CartItem existant existe pour l'article spécifié dans le panier.
    cart_item = cart_items.find_by(item: item)

    unless cart_item
      # Si l'article n'existe pas dans le panier, créez un nouvel enregistrement CartItem.
      cart_item = cart_items.create(item: item)
    end

    cart_item
  end
end
