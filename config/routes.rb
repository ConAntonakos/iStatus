Istatus::Application.routes.draw do
  resources :statuses
  match 'feed', :to => 'statuses#index', as: :feed
  root :to => 'statuses#index'

  get "profile/show"

  match "auth/:provider/callback", to: "sessions#create"
  match "/signin", to: "sessions#new", as: :signin
  match "/auth/failure", to: "sessions#failure"
  match '/signout', to: "sessions#destroy", as: :signout

  devise_for :users, :skip => [:registrations]                                          
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users' => 'devise/registrations#update', :as => 'user_registration'            
    end

  devise_scope :user do
    match 'register', :to => 'devise/registrations#new', as: :register
    match 'login', :to => 'devise/sessions#new', as: :login
    match 'logout', :to => 'devise/sessions#destroy', as: :logout
  end
  

  match '/:id', to: 'profiles#show', :via => :get

end
