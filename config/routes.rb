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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"

  namespace :api do
    namespace :blog do
      namespace :v1 do
        resources :users, only: [] do
          member do
            get :articles
          end
        end
        resources :articles do
        end
        resources :comments do
        end
      end
    end
  end
end
