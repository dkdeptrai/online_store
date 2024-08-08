# frozen_string_literal: true

# == Route Map
#
# bundle exec rails routes

Rails.application.routes.draw do
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'session/destroy'

  resources :users
  resources :products
  resources :pay_types

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      member do
        patch :decrease_quantity
      end
    end
    resources :carts
    root 'store#index', as: 'store_index', via: :all
  end
end
