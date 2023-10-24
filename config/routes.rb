Rails.application.routes.draw do
  
  namespace :public do
    patch 'customers/update'
    patch 'customers/withdraw'
    resources :customers, only: [:show, :edit, :confirm_withdraw]
  end
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  namespace :admin do
    post 'items/create'
    patch 'items/update'
    resources :items, only: [:new, :index, :show, :edit]
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
