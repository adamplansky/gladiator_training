Rails.application.routes.draw do
  resources :categories
  get '/password_resets/new'

  get '/password_resets/edit'

  resources :places
  get 'welcome/index'

  get 'reservations_users/index'

  get 'sessions/index'

  resources :users
  resources :reservations
  resources :sessions, only: [:new, :create, :destroy]
  resources :reservations_users
  resources :password_resets,only: [:new, :create, :edit, :update]

  match '/signup', to: 'users#new', via: 'get', as:"signup"
  match '/signin', to: 'sessions#new', via: 'get', as: "signin"
  match '/signout', to: 'sessions#destroy', via: 'delete'

  root to: 'welcome#index'
  match ':controller(/:action(/:id))', :via => :get
end
