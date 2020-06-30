Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'posts#index'
  #get 'home/top'
  get 'home/about'

  resources :posts do
    post "select_best_comment", :to => "posts#select_best_comment", as: 'select_best_comment'
    resources :comments do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 
  
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
  end

  namespace :users do
    post ":id/contact",:to => "profiles#contact",as: 'contact'
    get ":id/profile", :to => "profiles#show", as: 'profile'
    get ":id/profile/edit", :to => "profiles#edit", as: 'edit_profile'
    patch ":id/profile/update", :to => "profiles#update", as: 'update_profile'
  end

  get "inquiry_mailer/new", :to => "inquiry_mailer#new", as: 'new_inquiry_mailer'
  get "inquiry_mailer/confirm",:to => "inquiry_mailer#confirm",as: 'confirm_inquiry_mailer'
  get "inquiry_mailer/done",:to => "inquiry_mailer#done",as: 'done_inquiry_mailer'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
