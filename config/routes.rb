# frozen_string_literal: true

# == Route Map
#
# bundle exec rails routes

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'store/lazy_load', to: 'store#lazy_load'
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

  resources :support_requests, only: %i[index update]

  resources :users
  resources :products
  resources :pay_types
  resources :categories

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      member do
        patch :decrease_quantity
      end
    end
    resources :carts
    root 'store#index', as: 'store_index', via: :all

    mount ActionMailbox::Engine, at: '/rails/action_mailbox'
  end
end
