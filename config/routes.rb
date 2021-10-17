require 'sidekiq/web'

Rails.application.routes.draw do
  get 'graphics/index'
  resources :movies
  get 'dashboards/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboards#index'
  mount Sidekiq::Web => '/sidekiq'
end
