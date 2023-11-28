class CartItemsController < ApplicationController
  before_action :authenticate_user!


  def create
    puts "*********"
    puts "Params: #{params.inspect}" 
    puts "*********"
    item = Item.find(params.fetch(:item_id, nil))
    result = current_user.cart.add_item(item)

    if result.is_a?(CartItem) 
      redirect_to items_path, notice: "Item ajouté au panier avec succès"
    else
      redirect_to items_path, alert: result
    end
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
