# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # get 'apps/index'
  # get 'apps/new'
  # get 'apps/create'
  # get 'apps/edit'
  # get 'apps/update'
  # get 'apps/show'
  # get 'apps/destroy'
  resources :apps
  resources :scores
  resources :admins
  get :permissions, to: 'admins#permissions'
  put :permissions, to: 'admins#update_permissions'
  resources :burndowns
  resources :movies
  get 'dashboards/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboards#index'
  mount Sidekiq::Web => '/sidekiq'
end
