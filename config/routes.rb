Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'posts#index'
  #get 'home/top'
  get 'home/about'

  resources :posts do
    post "select_best_comment", :to => "posts#select_best_comment", as: 'select_best_comment'
    resources :comments,only: [:new, :create, :edit, :update] do
      patch "delete", :to => "comments#delete", as: 'delete'
      #resource :favorites, only: [:create, :destroy]
      get "favorites/create", :to => "favorites#create", as: 'create_favorite'
      get "favorites/destroy", :to => "favorites#destroy", as: 'destroy_favorite'
      resources :post_comments, only: [:create, :destroy]
    end
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  } 
  
  # devise_scope :user do
  #   get "user/:id", :to => "users/registrations#detail"
  # end

  namespace :users do
    get ":id/profile", :to => "profiles#show", as: 'profile'
    get ":id/profile/edit", :to => "profiles#edit", as: 'edit_profile'
    patch ":id/profile/update", :to => "profiles#update", as: 'update_profile'
    get ":id/profile/posts_show", :to => "profiles#posts_show", as: 'posts_show'
    get ":id/profile/favorite_comments_show", :to => "profiles#favorite_comments_show", as: 'favorite_comments_show'
    get ":id/profile/best_comments_show", :to => "profiles#best_comments_show", as: 'best_comments_show'
  end

  # namespaceにしたい
  get "inquiry_mailer/new", :to => "inquiry_mailer#new", as: 'new_inquiry_mailer'
  get "inquiry_mailer/confirm",:to => "inquiry_mailer#confirm",as: 'confirm_inquiry_mailer'
  get "inquiry_mailer/done",:to => "inquiry_mailer#done",as: 'done_inquiry_mailer'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
