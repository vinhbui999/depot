Rails.application.routes.draw do
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "store#index", as: "store_index" #paying customer

  get "store/get_time"
end
