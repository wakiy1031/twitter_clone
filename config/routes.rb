# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # resources :posts, only: %i[index show create]
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: %i[show edit update]
  resources :posts, only: %i[index show create] do
    resources :comments, only: %i[create]
    resource :likes, only: %i[create destroy]
  end

  root 'posts#index'
end
