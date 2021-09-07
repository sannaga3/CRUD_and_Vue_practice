Rails.application.routes.draw do
  resources :sessions, only: %i[ new create destroy ]
  resources :users, except: :index
  resources :tasks, only: %i[ index create update destroy ]
  root to: "sessions#new"
  resources :memos, only: %i[ index create update destroy ]
  resources :blogs, only: %i[ index create update destroy ]
end
