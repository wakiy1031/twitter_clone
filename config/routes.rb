# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :posts, only: %i[index]
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'posts#index'
end
