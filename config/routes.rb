Rails.application.routes.draw do
  resources :discount_items
  get 'payments/add'

  devise_for :users, controllers: { invitations: 'users/invitations' }
  root to:'admin#dashboard'

  resources :line_items
  resources :carts
  resources :discounts
  resources :products

  resources :users, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
