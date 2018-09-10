Rails.application.routes.draw do


  resources :gt_categories
  get 'memberships/all_members'
  get 'memberships/member'
  get 'memberships/notmember'
  get 'memberships/others'

  # constraints :subdomain => "gladiatorchallenge" do
  #   match "*path" => 'gt_races#index', via: :all
  # end

  constraints :subdomain => "gladiatorchallenge" do
    get "*all", to: redirect { |params, req| "http://#{req.domain}/gt_races/" }
    # get "*all", to: redirect { |params, req| "http://#{req.domain}/gt_races/#{params[:all]}" }
  end

  resources :gt_categories
  resources :gt_races do
    # scope module: :gt_races do
    resources :gt_prices, controller: "gt_races/gt_prices"
    # end
    #resources :gt_categories, controller: "gt_races/gt_categories"
    resources :starting_list, controller: "gt_races/starting_list"
    resources :mailers, controller: "gt_races/mailers" do
      collection do
        get 'send_unpaid_gt_races_mail'
      end
    end

    resources :gt_categories, controller: "gt_races/gt_guide_categories" do
      resources :gt_registrations, controller: "gt_races/gt_categories/gt_registrations" do
        collection do
          get 'index_with_payed'
        end
      end
    end
  end



  resources :challenge_categories
  resources :gym_wars
  resources :challenge_scores
  resources :user_teams
  resources :teams
  resources :users do
    collection do
      put 'complete'
    end
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
