Rails.application.routes.draw do
  devise_for :users
  resources :events, only: %i[index show new create edit update] do
    resources :experiences, only: %i[index new create edit update] do
      resources :notifications, only: %i[show edit update] do
        resources :guests_notifications, only: %i[new create destroy]
      end
    end
    resources :guests, only: %i[index new create edit update destroy]
  end
  resource :short_url, only: :show
  root to: 'events#index'
end
