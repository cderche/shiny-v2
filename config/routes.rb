Rails.application.routes.draw do
  resources :orders
  resources :discount_items

  devise_for :users, controllers: { invitations: 'users/invitations' }
  root to:'admin#dashboard'

  resources :line_items
  resources :carts

  resources :discounts
  resources :products
  resources :users, only: [:index]

  resources :payments, only: [] do
    collection do
      get   :add
      get   :charge
      post  :notification
    end
  end

  post :notifications, to: 'payments#notification'

  get :result, to: 'payments#result'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
