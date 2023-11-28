class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  def self.add_or_create_cart_item_link(permit_link_params)
    cart = Cart.find_by(id: permit_link_params[:cart_id])
    item = Item.find_by(id: permit_link_params[:item_id])

    if cart && item
      # Vérifie si un CartItem existant existe pour l'article spécifié dans le panier.
      cart_item = cart.cart_items.find_by(item: item)

      if cart_item
        # Si l'article existe déjà dans le panier, ne rien faire et retourner le message.
        return "Cet item est déjà présent dans le panier"
      else
        # Sinon, créez un nouvel enregistrement CartItem pour cet article dans le panier.
        cart_item = cart.cart_items.create(item: item)
      end

      cart_item
    else
      # Gérer le cas où le panier ou l'article n'est pas trouvé.
      nil
    end
  end
end
