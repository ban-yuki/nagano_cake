Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  namespace :public do
    patch 'current_customers/update'
    patch 'current_customers' => 'public/customers#update'
    get  '/current_customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch  '/current_customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit]
    resources :items, only: [:index, :show,]
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    post 'items/create' => 'items#create'
    patch 'items/:id' => 'items#update'
    patch 'customers/:id' => 'customers#update'
    resources :items, only: [:new, :index, :show, :edit]
    resources :customers, only: [:index, :show, :edit]
  end
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
