Rails.application.routes.draw do
  devise_for :users
  resources :chats
  root 'chats#index'
  resources :users
  get 'search', to: 'search#index'
  resources :groups

  # get 'sign_out', to: 'users#sign_out'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
