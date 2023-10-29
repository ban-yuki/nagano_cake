Rails.application.routes.draw do

  namespace :public do
    patch 'current_customers/update'
    get '/customers/sign_up', to: 'public/registrations#new'
    post '/customers', to: 'public/registrations#create'
    get 'sessions/new'
    get  '/current_customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch  '/current_customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit]
  end
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",

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
