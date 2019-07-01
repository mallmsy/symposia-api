Rails.application.routes.draw do
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :users, only: [:index, :create, :update]
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  get '/fetch', to: 'posts#fetch_articles'
end
