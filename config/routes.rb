Rails.application.routes.draw do
  root "static_pages#home"

  get "static_pages/about"
  get "static_pages/help"

  get "words/index"

  resources :users

  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
end
