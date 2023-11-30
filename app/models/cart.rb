# app/models/cart.rb
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  def add_item(item, quantity)
    # Vérifie si un CartItem existant existe pour l'article spécifié dans le panier.
    cart_item = cart_items.find_by(item: item)

    if cart_item
      # Si l'article existe déjà dans le panier, mettez à jour la quantité en vérifiant si elle est nil.
      new_quantity = cart_item.quantity.to_i + quantity.to_i
      cart_item.update(quantity: new_quantity)
      return "Quantité mise à jour dans le panier"
    else
      # Sinon, créez un nouvel enregistrement CartItem pour cet article dans le panier avec la quantité spécifiée.
      cart_item = cart_items.create(item: item, quantity: quantity)
      return cart_item
    end
  end
end
