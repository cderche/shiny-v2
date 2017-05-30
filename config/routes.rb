Rails.application.routes.draw do
  devise_for :users
  root to:'admin#dashboard'

  resources :line_items
  resources :carts
  resources :discounts
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
