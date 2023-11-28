class ApplicationController < ActionController::Base

  include ApplicationHelper
  after_action :create_cart_and_assign_to_current_user, only: [:create]
  #créér un panier et l’associer à l’utilisateur en même temps que celui-ci est créé
end