Rails.application.routes.draw do
  devise_for :users
  resources :events, only: %i[index show edit] do
    resources :experiences, only: %i[index edit]
    resources :guests, only: %i[index edit]
  end
  root to: 'events#index'
end
