Rails.application.routes.draw do
  resources :comments, only: [:index, :create, :destroy, :update]
  resources :likes, only: [:create, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :users, only: [:index, :create, :update]
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  get '/fetch', to: 'fetch#fetch_articles'
  mount ActionCable.server => '/cable'
end
