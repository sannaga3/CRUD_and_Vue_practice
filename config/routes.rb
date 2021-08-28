Rails.application.routes.draw do
  resources :tasks
  root to: "memos#index"
  resources :memos, only: %i[ index create update destroy ]
  resources :blogs, only: %i[ index create update destroy ]
end
