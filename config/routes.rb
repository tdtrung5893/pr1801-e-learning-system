Rails.application.routes.draw do
  root "static_pages#home"

  get "static_pages/about"
  get "static_pages/help"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  get "words/index"

  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :categories do
    resources :lessons
  end
end
