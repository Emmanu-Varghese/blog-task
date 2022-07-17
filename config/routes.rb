require "sidekiq/web"

Rails.application.routes.draw do
  resources :articles do
    resources :comments, except: [:index] do
      resource :emote, only: :show
    end
  end
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
