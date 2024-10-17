Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resource :like, only:[:create, :destroy]
    resources :orders
    resources :comments
    
  end
end
