class OrderMailer < ApplicationMailer
  default from: 'courtois.a@hotmail.com'

  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Récapitulatif de votre commande') do |format|
      format.html do
        # Ajouter les pièces jointes ici si nécessaire
        @order.items.each do |item|
          image_path = "app/assets/images/#{item.cart.image_filename}"
          if File.exist?(image_path)
            attachments[item.cart.image_filename] = File.read(image_path)
          else
            Rails.logger.warn("Image not found at #{image_path}")
          end
        end
      end
    end
  end
end
