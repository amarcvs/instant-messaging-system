Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }, skip: [:sessions, :registrations]
  
  # changing the default paths
  # When you are using only one role with Devise you may want to change the sign in and sign out routes to /login and /logout (instead of /users/sign_in and /users/sign_out).
  devise_scope :user do
    get '/login', to: 'devise/sessions#new', as: :new_user_session
    post '/login', to: 'devise/sessions#create', as: :user_session
    delete '/logout', to: 'devise/sessions#destroy', as: :destroy_user_session
    get '/signup', to: 'devise/registrations#new', as: :new_user_registration
    post '/signup', to: 'devise/registrations#create', as: :user_registration

  end

  resources :messages
  resources :rooms
  
  root 'pages#index'
  get '/rooms', to: 'rooms#index', :as => :room_view

  #Admin Actions
  get '/adminPanel', to: 'admins#index', :as => :admin_view
  get '/adminPanel/ban/:id', to: 'admins#ban_user', :via => :get, :as => :admin_ban_user
  get '/adminPanel/unban/:id', to: 'admins#unban_user', :via => :get, :as => :admin_unban_user
  get '/adminPanel/admin/:id', to: 'admins#admin_user', :via => :get, :as => :admin_admin_user
  get '/adminPanel/unadmin/:id', to: 'admins#unadmin_user', :via => :get, :as => :admin_unadmin_user

end
