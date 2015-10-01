Rails.application.routes.draw do
  get 'welcome/index'

  get 'reservations_users/index'

  get 'sessions/index'

  resources :users
  resources :workouts
  resources :groups
  resources :reservations
  resources :sessions, only: [:new, :create, :destroy]
  resources :reservations_users
  
  
  match '/signup', to: 'users#new', via: 'get', as:"signup"
  match '/signin', to: 'sessions#new', via: 'get', as: "signin"
  match '/signout', to: 'sessions#destroy', via: 'delete'
  
  root to: 'welcome#index'
end
