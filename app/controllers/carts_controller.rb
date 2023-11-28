class CartsController < ApplicationController

  
  def show
    @cart_items = current_user.cart.cart_items.includes(:item)
  end

  def create
  end

  def update
  end

  def destroy
  end
end
