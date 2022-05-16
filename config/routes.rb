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
  root "articles#index"

  namespace :api do
    namespace :blog do
      namespace :v1 do
        resources :users, only: [] do
          resources :articles do
            resources :comments, except: :show do
              member do
                get :add_emote, path: "add-emote"
                get :remove_emote, path: "remove-emote"
              end
            end
          end
        end
      end
    end
  end
end
