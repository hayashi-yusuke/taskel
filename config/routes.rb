Rails.application.routes.draw do

  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
    get "top", to: "homes#top", as: :top
    resources :users, only: [:index, :destroy]
    resources :tasks, only: [:index, :destroy]
  end

  resource :session
  post "/guest_login", to: "sessions#guest_login", as: :guest_login
  resources :passwords, param: :token

  get "/", to: "homes#top", as: :root
  get "/about", to: "homes#about", as: :about

  get "/mypage", to: "users#mypage", as: :mypage
  get "/likes", to: "likes#index", as: :likes
  resources :users, only: [ :index, :new, :create, :edit, :show, :update, :destroy ] do
    resource :follow, only: [ :create, :destroy ]
    member do
      get :followings
      get :followers
    end
  end

  resources :tasks, only: [ :index, :show, :create, :edit, :update, :destroy ] do
    member do
      patch :complete
    end
    resources :comments, only: [ :create, :destroy ]
    resource :like, only: [ :create, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end