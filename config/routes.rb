Rails.application.routes.draw do

  resources :orders, only: [:new, :create]
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  root 'static_pages#index'
  
  get 'static_pages/index'

  devise_for :users

  resources :items do
    post 'add_to_cart', on: :member
  end #cette configuration de route crée une route POST spécifique pour l'action add_to_cart qui peut être utilisée pour ajouter un article spécifique au panier. 

  resources :carts, only: [:create, :show, :update, :destroy]
  resources :cart_items, only: [:create, :show, :update, :destroy]

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
