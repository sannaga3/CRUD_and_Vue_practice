Rails.application.routes.draw do
  root to: "memos#index"
  resources :memos, only: %i[ index create update destroy ]
  resources :blogs, only: %i[ index create update destroy ]
end
