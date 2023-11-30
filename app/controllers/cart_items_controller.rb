class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create

    item = Item.find(params.fetch(:item_id, nil))
    quantity = params.fetch(:quantity, 1).to_i  # Utilisez la quantité fournie, sinon par défaut à 1
    result = current_user.cart.add_item(item, quantity)
    #OrderMailer.order_notification(current_user, @order).deliver_now
    
    if result.is_a?(CartItem) 
      redirect_to items_path, notice: "Item ajouté au panier avec succès"
    else
      redirect_to items_path, notice: "Erreur : l'item dejà présent dans le panier"
    end
  end

  def update

  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_back(fallback_location: cart_path, notice: "L'item a été supprimé du panier avec succès")

  end

  private

  def permit_link_params
    params.require(:cart_item).permit(:item_id, :cart_id)
  end

end
