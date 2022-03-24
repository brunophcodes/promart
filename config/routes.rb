Rails.application.routes.draw do
  #get 'carts/:id', to: "carts#show", as: "cart"
  get 'carts/my_cart', to: "carts#show", as: "cart"
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  delete 'carts/:id', to: "carts#destroy"

  post 'order_items/:id/add', to:  "order_items#add_quantity", as: "order_item_add"
  post 'order_items/:id/reduce', to: "order_items#reduce_quantity", as: "order_item_reduce"
  post 'order_items', to: "order_items#create"
  get 'order_items/:id', to: "order_items#show", as: "order_item"
  delete 'order_items/:id', to: "order_items#destroy"

  resources :products
  resources :orders
end
