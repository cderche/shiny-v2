Rails.application.routes.draw do
  resources :carts
  resources :discounts
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
