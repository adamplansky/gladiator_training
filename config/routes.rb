Rails.application.routes.draw do


  match '/gt_registrations/index_with_payed', to: 'gt_registrations#index_with_payed', via: 'get'
  resources :gt_registrations
  resources :gt_prices

  resources :gt_races do
    resources :starting_list do
    end
  end

  resources :challenge_categories
  resources :gym_wars
  resources :challenge_scores
  resources :user_teams
  resources :teams
  resources :users do
    resources :gymwars, controller: 'user_gym_wars' do
      collection do
        get 'index'
        get 'edit' => 'user_gym_wars#edit', :as => :edit_user_gym_wars
        put 'edit' => 'user_gym_wars#update'
      end
    end
  end

  resources :seasons do
    resources :leaderboards do
      collection do
        get 'index'
        get 'men'
        get 'women'
        get 'gyms'
        get 'mixes'
      end
    end
  end

  resources :challenges do
    resources :leaderboards, controller: 'challenge_leaderboards' do
      collection do
        get 'men'
        get 'women'
        get 'gyms'
        get 'mixes'
      end
    end
  end

  resources :gyms
  resources :events
  resources :reacttests
  resources :links
  get 'about_us/index'

  resources :dictionaries
  resources :periods
  resources :trainings
  resources :training_categories
  resources :categories
  get '/password_resets/new'
  get '/password_resets/edit'

  resources :places
  get 'welcome/index'
  get 'reservations_users/index'
  get 'sessions/index'

  resources :trainings do
    member do
      put :update_super
      get :edit_super
    end
  end

  resources :reservations
  resources :sessions, only: [:new, :create, :destroy]
  resources :reservations_users
  resources :password_resets,only: [:new, :create, :edit, :update]
  resources :registrations, only: [:edit, :update, :show, :create, :destroy]
  resources :statistics, only: [:index, :show]
  match '/signup', to: 'users#new', via: 'get', as: "signup"
  match '/signin', to: 'sessions#new', via: 'get', as: "signin"
  match '/signout', to: 'sessions#destroy', via: 'delete'
  get '/.well-known/acme-challenge/:id' => 'welcome#letsencrypt'


  root to: 'welcome#index'
  match ':controller(/:action(/:id))', :via => :get
end
