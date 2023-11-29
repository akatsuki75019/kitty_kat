class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @item_id = params[:item_id]
    @user_id = params[:user_id]
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
        item_id: @item_id,
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
    @item_id = @session.metadata.item_id 


    # Création d'une nouvelle instance dans la BDD Order
    @order = Order.create(user_id: current_user.id)

    #Création des instances dans la table jointe order_items
    OrderItem.create(order_id: @order.id, item_id: @item_id)

     
  end


  def cancel
  end

end