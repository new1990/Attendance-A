Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  # ログイン
  get '/login', to: 'sessions#new'
  get '/login', to: 'sessions#ncreate'
  get '/logout', to: 'sessions#destroy'
  
  resources :users
end
