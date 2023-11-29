class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @user_id = params[:user_id]
    @cart_items = current_user.cart.cart_items.includes(:item)
    total_price = @cart_items.sum { |cart_item| cart_item.item.price }
  
    cart_item_ids = @cart_items.pluck(:id)
  

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      metadata: {
        cart_item_ids: cart_item_ids.join(','),
        user_id: @user_id
       
      },
      mode: 'payment',
      customer_email: current_user.email, 
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  
  end

  def success

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    cart_item_ids = @session.metadata.cart_item_ids
   

    # Création d'une nouvelle instance dans la BDD Order
    @order = Order.create(user_id: current_user.id)

    # Récupération de l'order_id nouvellement créé
    @order_id = @order.id


    
    # Récupération des IDs des cart_items depuis les métadonnées
    cart_item_ids = @session.metadata.cart_item_ids.split(',').map(&:to_i)


    #Création des instances dans la table jointe order_items
    cart_item_ids.each do |cart_item_id|
      cart_item = CartItem.find(cart_item_id)
      OrderItem.create(order_id: @order.id, item_id: cart_item.item_id)
    end

    # Effacer les articles du panier après la commande
      current_user.cart.cart_items.destroy_all
  end


  def cancel
  end

end