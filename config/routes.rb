Rails.application.routes.draw do

  get 'order/new'

  root 'products#index'
  get 'products/new'

  get 'products/index'
  resources :products

  get 'sessions/new'

  get 'carts/new'
  get 'carts/index'

  get 'users/new'

  # get 'users/carts', to: 'users#user_cart'

  get 'static_pages/home'

  get 'static_pages/about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users do
    member do
      get 'carts' 
      get 'orders'
      get 'orders_history'
    end
  end
  
  resources :carts

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
