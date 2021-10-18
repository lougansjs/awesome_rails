# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :admins
  resources :burndowns
  resources :movies
  get 'dashboards/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboards#index'
  mount Sidekiq::Web => '/sidekiq'
end
