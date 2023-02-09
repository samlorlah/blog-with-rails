# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, default: { format: :json }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create, :new]
    end
  end
  resources :posts, only: [:new, :create, :destroy]
  resources :comments, only: [:destroy]

  namespace :api do
    resources :users, only: [] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end
