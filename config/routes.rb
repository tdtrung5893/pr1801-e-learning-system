Rails.application.routes.draw do
  root "categories#index"

  get "static_pages/about"
  get "static_pages/help"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  get "words/index"

  resources :categories, shallow: true do
    resources :lessons
  end

  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :categories, except: [:new, :create, :edit, :update] do
    resources :lessons, except: [:new, :create, :edit, :update]
  end

  namespace :admin do
    resources :users
    resources :categories do
      resources :lessons, except: [:show]
    end
  end
end
