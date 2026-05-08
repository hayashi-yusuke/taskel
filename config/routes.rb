Rails.application.routes.draw do
  resource :session
  post "/guest_login", to: "sessions#guest_login", as: :guest_login
  resources :passwords, param: :token

  get "/", to: "homes#top", as: :root
  get "/about", to: "homes#about", as: :about

  get "/mypage", to: "users#mypage", as: :mypage
  resources :users, only: [ :new, :create, :edit, :show, :update, :destroy ]

  resources :tasks, only: [ :index, :show, :create, :edit, :update, :destroy ] do
    member do
      patch :complete
    end
    resources :comments, only: [ :create, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
