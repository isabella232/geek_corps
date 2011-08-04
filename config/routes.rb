GeekCorps::Application.routes.draw do

  post "comments/create"

  resources :languages
  resources :skills
  resources :roles
  resources :details

  resources :teams do
    resources :members
    member do
      get 'admin'
      get 'people'
    end
  end

  resources :regions

  resources :apps do
    resources :teams
    resources :goals do
      resources :milestones do
        resources :steps
      end
    end
    member do
      get 'people'
      get 'admin'
      get 'steps'
    end
  end

  root :to => "people#index"

  resources :authentications

  resources :people do
    collection do
      get 'grid', :action => :index, :grid => '1'
    end
    member do
      get 'claim'
      get 'photo'
    end
  end
  get '/people/tag/:tag(.:format)' => 'people#tag', :as => 'people_tagged', :constraints => {:tag => /.*/}

  resources :users, :only => [:show, :index, :destroy] do
    member do
      post 'adminify'
    end
  end
  get '/welcome' => 'users#welcome', :as => 'welcome_users'
  get '/home' => 'users#home', :as => 'home_users'

  resources :user_sessions, :only => [:new, :create], :controller => 'users/sessions'

  devise_for :users do
    get "/sign_out" => "devise/sessions#destroy"
    get "/sign_in" => "users/sessions#new"
  end

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/auto' => 'authentications#auto'
  match '/auth/failure' => 'authentications#auth_failure'
  match '/:team_name' => 'teams#show'
  match '/apps/:id/people' => 'apps#people', :as => 'apps_people'
  match '/:team_name/people' => 'teams#people', :as => 'teams_people'

  get 'privacy' => 'pages#privacy'
  get 'about' => 'pages#about'
  get 'api' => 'pages#api'
  get 'blog' => 'pages#blog'
  get 'contact' => 'pages#contact'
  get 'terms' => 'pages#terms'

end
