class OrdersController < ApplicationController
  def new
  end
  
  def create
    
    if current_user
      
      @order = current_user.orders.build

      
      params[:item_ids].each do |item_id|
        item = Item.find(item_id)
        @order.items << item if item
      end

     
      if @order.save
       
        OrderMailer.order_confirmation(current_user, @order).deliver_now

        
        redirect_to root_path, notice: 'Votre commande a été effectuée avec succès!'
      else
       
        redirect_to root_path, alert: 'Erreur lors de la création de la commande.'
      end
    else
      
      redirect_to root_path, alert: 'Vous devez être connecté pour effectuer une commande.'
    end
  end
end
