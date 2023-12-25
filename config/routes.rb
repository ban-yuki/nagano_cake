Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    patch '/current_customers/update'
    patch '/current_customers' => 'public/customers#update'
    get  '/current_customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch  '/current_customers/withdraw' => 'customers#withdraw'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/confirm_orders' => 'orders#confirm_orders'
    post '/orders' => 'orders#create'
    get '/cart_items' => 'cart_items#index'
    post '/cart_items' => 'cart_items#create'
    patch '/cart_items/:id/update' => 'cart_items#update', as: "cart_item"
    delete '/cart_items/:id/destroy' => 'cart_items#destroy', as: "cart_item_delete"
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :customers, only: [:show, :edit]
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :index, :show]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get '', to: 'homes#top'
    patch 'customers/:id' => 'customers#update'
    resources :items, only: [:new, :index, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit]
    resources :orders, only: [:show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
