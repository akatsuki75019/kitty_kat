class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :nullify
  has_many :items, through: :cart_items


  def add_item(item)
    #vérifie si un CartItem existant existe pour l'article spécifié dans le panier. Si tel est le cas, elle incrémente simplement la quantité. 
    #Sinon, elle crée un nouvel enregistrement CartItem pour cet article dans le panier.
    cart_item = cart_items.find_or_initialize_by(item: item)
    cart_item.quantity += 1
    cart_item.save
  end


end
