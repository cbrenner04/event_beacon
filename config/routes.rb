Rails.application.routes.draw do
  devise_for :users
  resources :events, only: %i[index show new create edit update] do
    resources :experiences, only: %i[index new create edit update] do
      resources :notifications, only: %i[show edit update] do
        get :preview_email, on: :member
        resources :guests_notifications, only: %i[new create destroy]
      end
    end
    resources :guests, only: %i[index new create edit update destroy]
  end
  resource :short_url, only: :show
  resource :end_user_agreement, only: :show
  resource :privacy_policy, only: :show
  resource :terms_and_conditions, only: :show
  get 'contact_us', to: 'contacts#new'
  resources :contacts, only: [:create]
  root to: 'events#index'
end
