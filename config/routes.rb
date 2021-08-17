Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get "admin" => "admin#index"
  resources :users
  # resources :orders
  # resources :line_items
  # resources :carts
  resources :products do
    get :who_bought, on: :member
  end

  controller :sessions do
    get "/login" => :new
    post "/login" => :create
    delete "/logout" => :destroy
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root "store#index", as: "store_index" #paying customer

  get "store/get_time"
  # scope "(:locale)" do 
    resources :orders
    resources :line_items
    resources :carts
    root "store#index", as: "store_index", via: :all   
  # end
end
