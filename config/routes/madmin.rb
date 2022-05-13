# Below are the routes for madmin
namespace :madmin do
  resources :pages
  namespace :active_storage do
    resources :blobs
  end
  namespace :active_storage do
    resources :variant_records
  end
  resources :users
  resources :services
  namespace :active_storage do
    resources :attachments
  end
  resources :announcements
  resources :licenses
  root to: "dashboard#show"
end
