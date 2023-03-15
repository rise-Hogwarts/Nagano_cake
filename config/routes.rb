Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
   sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  scope module: :public do#顧客・会員
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/customers/confirm' => 'customers#confirm', as: 'confirm'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    post '/cart_item/:id' => 'cart_items#update', as: 'cart_item'
    delete '/cart_item/:id' => 'cart_items#destroy', as: 'destroy_cart_item'
    delete '/cart_items' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    post '/orders/confirm' => 'orders#confirm', as: 'order_confirm'
    get '/orders/complete' => 'orders#complete', as: 'complete'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :confirm, :withdraw]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :orders, only: [:new, :confirm, :complete, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end


  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
  end

end
