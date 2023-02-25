Rails.application.routes.draw do
  devise_for :admin
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  namespace :public do  #顧客・会員
    root to: 'homes#top'
    get '/about' => 'homes#about'
  end

end
