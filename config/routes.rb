Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :messages
  resources :rooms
  
  root 'rooms#index'
  
end
