Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#top'
  get 'home/about'

  resources :posts do
    post "select_best_comment", :to => "posts#select_best_comment", as: 'select_best_comment'
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
    get ":id/profile", :to => "profiles#show", as: 'profile'
    get ":id/profile/edit", :to => "profiles#edit", as: 'edit_profile'
    patch ":id/profile/update", :to => "profiles#update", as: 'update_profile'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
