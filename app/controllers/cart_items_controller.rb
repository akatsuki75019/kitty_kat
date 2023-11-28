class CartItemsController < ApplicationController
  before_action :authenticate_user!


  def create
    item = Item.find(params[:item_id])
    current_user.cart.add_item(item)
    redirect_to items_path, notice: "Item ajouté au panier avec succès"
  end

  def update
     # Vous pouvez implémenter la mise à jour de la quantité d'un article dans le panier ici
  end

  def destroy
  end

  private

  def permit_link_params
    params.require(:cart_item).permit(:item_id, :cart_id)
  end

end
