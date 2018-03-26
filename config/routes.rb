Rails.application.routes.draw do

  devise_for :users
  resources :users do
    resources :posts
  end

  resources :comments
  resources :post_likes, only: [:new, :create]
  resources :comment_likes, only: [:new, :create]
  resources :friendships, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]
  get '/sent_friend_requests', to: 'friend_requests#sent_requests'
  get '/received_friend_requests', to: 'friend_requests#received_requests'
  get '/friends', to: 'friendships#friends'
  get 'myprofile', to: 'users#my_profile'
  root 'posts#index'

end
