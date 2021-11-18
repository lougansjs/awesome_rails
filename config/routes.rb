# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  resources :reminders
  resources :apps
  resources :scores do
    post :calculate, on: :collection
    match 'functionalities/:id', to: 'scores#functionalities', via: :get, as: :functionalities, on: :collection
  end
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
