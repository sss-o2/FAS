Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#top'
  get 'home/about'

  resources :posts do
    resources :comments
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  namespace :users do
    get ":id/profile", :to => "profiles#show", as: 'user_profile_path'
    get ":id/profile/edit", :to => "profiles#edit", as: 'edit_user_profile_path'
    patch ":id/profile/update", :to => "profiles#update"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
