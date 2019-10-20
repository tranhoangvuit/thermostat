Rails.application.routes.draw do
  
  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :reading, only: [:index, :create]
  resources :stats, only: [:index]

end
