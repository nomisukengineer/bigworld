Rails.application.routes.draw do

  get 'order/new'

  root 'products#index'
  get 'products/new'
  post 'products/new', to: 'products#create'
  get 'products/mens', to: 'products#mens'
  get 'products/ladies', to: 'products#ladies'
  get 'products/analytics', to: 'products#analytics'
  get 'products/:id/edit', to: 'products#edit'
  get 'products/:id/update', to: 'products#update'

  resources :products

  get 'sessions/new'

  get 'carts/new'
  get 'carts/index'

  get 'users/new'
  get 'users/admin_user', to:'users#new'
  # get 'users/carts', to: 'users#user_cart'
  resources :users do
      get 'carts', on: :member
      post 'carts', to: 'users#create_carts', on: :member
      delete 'carts', to:'users#destroy_carts', on: :member
      get 'orders', on: :member
      get 'orders_history', on: :member
      post 'favorites', to: 'users#create_favorites', on: :member
      get 'favorites', on: :member
      delete 'favorites', to:'users#destroy_favorites', on: :member
      get 'thankyou', on: :member
      #patch 'thankyou', to: 'users#thankyou',on: :member
  end
  

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'static_pages/home'
  get 'static_pages/about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
