Rails.application.routes.draw do
  devise_for :users
  resources :events, only: %i[index show edit] do
    resources :experiences, only: %i[index edit] do
      resources :notifications, only: %i[show]
    end
    resources :guests, only: %i[index edit]
  end
  resources :guests_notifications, only: :destroy
  root to: 'events#index'
end
