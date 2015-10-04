Rails.application.routes.draw do
  resources :quotes
  resources :articles
  resources :codes
  resources :companies
  devise_for :users
  root "pages#home"
end
