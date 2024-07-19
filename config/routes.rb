# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # resources :posts, only: %i[index show create]
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: %i[show edit update] do
    resources :follows, only: %i[index create destroy]
    resources :rooms, only: %i[create]
  end

  resources :posts, only: %i[index show create] do
    resources :comments, only: %i[create]
    resource :likes, only: %i[create destroy]
    resource :reposts, only: %i[create destroy]
    resource :bookmarks, only: %i[create destroy]
  end

  resources :bookmarks, only: %i[index]

  resources :rooms, only: %i[index show] do
    resources :messages, only: %i[create]
  end

  root 'posts#index'
end
