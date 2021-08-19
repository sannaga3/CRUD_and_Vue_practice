Rails.application.routes.draw do
  root to: "memos#index"
  resources :memos, except: %i[ show ]
end
