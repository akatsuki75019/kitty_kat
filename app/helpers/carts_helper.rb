module CartsHelper
  #sécurité pour qu'un user ne puisse pas afficher le cart d'un autre user
  def only_current_cart
    if current_user != nil && current_user.cart.id != params[:id].to_i
        return redirect_to cart_path(current_user.cart.id)
    end
  end
end
