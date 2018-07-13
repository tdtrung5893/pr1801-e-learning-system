Rails.application.routes.draw do
  root "categories#index"

  get "/words", to: "static_pages#home"
  get "static_pages/about"
  get "static_pages/help"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :user_words, only: [:index, :create]
  resources :user_lessons, only: [:index, :new, :create]
  resources :users
  resources :categories, only: [:index, :show] do
    resources :lessons, only: [:index, :show] do
      resources :words, only: [:index, :show]
    end
  end

  namespace :admin do
    resources :users
    resources :categories do
      resources :lessons do
        resources :words
      end
    end
  end
end
