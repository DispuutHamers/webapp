Hamers::Application.routes.draw do
  mount LetsencryptPlugin::Engine, at: '/'
  apipie
  resources :notes
  resources :pushes, only: [:index, :create, :new]
  resources :stickers
  get '/mystickers' => 'stickers#personal', as: 'personal_sticker'

  resources :news
  get '/images' => 'albums#index', as: 'photo'
  get '/trail' => 'static_pages#trail' , as: 'trail' 
  get '/trail' => 'static_pages#trail' , as: 'device' 

  match 'api/v1/:key/:request', to: 'api#GET', via: 'get'
  match 'api/v1/:key/:request/:id', to: 'api#GET', via: 'get'
  match 'api/v1/:key/:request', to: 'api#POST', via: 'post'
  match 'api/v1/:key/:request', to: 'api#PUT', via: 'put'
  match 'api/v1/:key/:request', to: 'api#DESTROY', via: 'destroy'
  match '/api/v1/noaccess', to: 'api#noaccess', via: 'get'
  match '/webconsole', to: 'static_pages#console', via: 'get'
  resources :motions
  resources :api_keys, only: [:create, :show, :destroy]
  resources :public_pages

  resources :meetings

  resources :beers do
    member do
      get :reviews
    end
  end

  resources :events
  get '/ical/:key' => "events#index"

  resources :votes

  resources :polls
  resources :signups
  resources :nicknames

  root  'static_pages#home'

  resources :users do
    member do
      get :usergroups
    end
  end

  get 'leden', to: "users#index_public", as: "public_leden"

  resources :reviews, only: [:create, :destroy, :update, :edit]
  resources :groups, only: [:create, :destroy]
  resources :usergroups, only: [:create, :destroy]
  resources :quotes, only: [:create, :destroy, :update, :edit]
  resources :sessions, only: [:new, :create, :destroy]

  match '/notuleer/:id', to: 'meetings#notuleer', via: 'get'
  match '/dbdump', to: 'dbdump#show', via: 'get'
  match '/groups', to: 'usergroups#index', via: 'get'
  match '/register',  to: 'users#new',            via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/stats', to: 'static_pages#statistics', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/:id', to: 'public_pages#show', via: 'get'
  scope 'endpoints' do
    get 'email' => 'endpoints/email#create'
  end

  scope 'api' do
    scope 'v2' do
      resources :users, module: 'api2', only: [:index, :show]
      resources :beers, module: 'api2', only: [:index, :show, :update, :create]
      resources :quotes, module: 'api2', only: [:index, :show, :update, :create]
      resources :meetings, module: 'api2', only: [:index, :show, :update, :create]
      resources :news, module: 'api2', only: [:index, :show, :update, :create]
      resources :signups, module: 'api2', only: [:show, :update, :create]
      resources :stickers, module: 'api2', only: [:index, :show, :create]
      resources :reviews, module: 'api2', only: [:index, :show, :update, :create]
      resources :events, module: 'api2', only: [:index, :show, :update, :create]
      resources :motions, module: 'api2', only: [:index, :show, :update, :create]
      get 'full_backup' => 'api2/backups#index'
      get 'whoami' => "api2/users#whoami"
      post 'register' => "api2/api#register"
    end
  end
end
