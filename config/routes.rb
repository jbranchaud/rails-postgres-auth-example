Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]
  resources :users, only: [:show]
end
