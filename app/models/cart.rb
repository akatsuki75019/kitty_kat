class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :nullify
  has_many :items, through: :cart_items

  def add_item(item)
    # Vérifie si un CartItem existant existe pour l'article spécifié dans le panier.
    cart_item = cart_items.find_by(item: item)

    if cart_item
      # Si l'article existe déjà dans le panier, ne rien faire et retourner le message.
      return "Cet item est déjà présent dans le panier"
    else
      # Sinon, créez un nouvel enregistrement CartItem pour cet article dans le panier.
      cart_item = cart_items.create(item: item)
      return cart_item
    end
  end
end