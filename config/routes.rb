Rails.application.routes.draw do
  devise_for :users
  resources :events, only: %i[index show] do
    resources :experiences, only: %i[index edit update] do
      resources :notifications, only: %i[show edit update]
    end
    resources :guests, only: %i[index edit update]
  end
  resources :guests_notifications, only: :destroy
  root to: 'events#index'
end
