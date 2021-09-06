Rails.application.routes.draw do
  resources :users, except: :index
  resources :tasks, only: %i[ index create update destroy ]
  root to: "memos#index"
  resources :memos, only: %i[ index create update destroy ]
  resources :blogs, only: %i[ index create update destroy ]
end
