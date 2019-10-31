Rails.application.routes.draw do
  get 'carts/new'

  root 'products#index'
  get 'products/new'

  get 'products/index'
  resources :products

  get 'sessions/new'


  get 'users/new'

  get 'static_pages/home'

  get 'static_pages/about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
