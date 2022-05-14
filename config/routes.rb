require "sidekiq/web"

Rails.application.routes.draw do
  resources :comments do
    resource :emote, only: :show
  end
  resources :articles
  mount Sidekiq::Web => "/sidekiq"

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users
  # root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
end
