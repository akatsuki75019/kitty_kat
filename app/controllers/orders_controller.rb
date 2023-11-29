class OrdersController < ApplicationController
  def new
  end

  def create
      # Before the rescue, at the beginning of the method
    @stripe_amount = 500
    begin
      session = Stripe::Checkout::Session.create({
        line_items: [{
          # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
          price: '{{PRICE_ID}}',
          quantity: 1,
        }],
        mode: 'payment',
        success_url: ENV['YOUR_DOMAIN'] + '/success.html',
        cancel_url: ENV['YOUR_DOMAIN'] + '/cancel.html',
        automatic_tax: {enabled: true},
      })
      redirect session.url, 303
    end
    # After the rescue, if the payment succeeded
  end
end
