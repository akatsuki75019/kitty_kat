class ApplicationController < ActionController::Base

  include ApplicationHelper
  after_action :create_cart_and_assign_to_current_user, only: [:create]
  #appelle de la methode "create cart &assign" apres que l'action de création soit terminée
end
