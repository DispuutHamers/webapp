Hamers::Application.routes.draw do
  use_doorkeeper
  mount LetsencryptPlugin::Engine, at: '/'
  apipie
  resources :notes
  resources :pushes, only: [:index, :show, :create, :new]
  resources :stickers
  get '/mystickers' => 'stickers#personal', as: 'personal_sticker'

  resources :news
  get '/images' => 'albums#index', as: 'photo'
  get '/trail' => 'static_pages#trail' , as: 'trail'
  get '/trail' => 'static_pages#trail' , as: 'device'
  get '/quotes/:id' => 'static_pages#quote', as: 'quote'
  get '/remind/:id' => 'events#remind', as: 'reminder'
  get '/beers/search' => 'beers#search'
  post '/beers/search' => 'beers#search', as: 'beer_search'

  match '/webconsole', to: 'static_pages#console', via: 'get'
  resources :motions
  resources :api_keys, only: [:create, :show, :destroy]
  resources :public_pages
  resources :blogitems, path: 'blog'
  post 'blog/:id' => "blogitems#add_photo"
  post 'blog/:blogitem/:blogphoto' => "blogitems#destroy_photo"
  post 'revert/:model/:id' => "static_pages#revert"

  resources :meetings

  resources :beers do
    member do
      get :reviews
    end
  end

  resources :events
  get '/ical/:key' => "events#index"

  resources :signups
  resources :nicknames

  root  'static_pages#home'

  devise_for :users 
  devise_scope :user do 
    get 'signin', to: 'devise/sessions#new', as: "signin"
  end
  resources :users do
    member do
      get :usergroups
    end
  end
  match '/external_accounts', to: 'users#index_extern', via: 'get', as: 'external_accounts'

  get 'leden', to: "users#index_public", as: "public_leden"

  resources :reviews, only: [:show, :create, :destroy, :update, :edit]
  resources :groups, only: [:create, :destroy]
  resources :usergroups, only: [:create, :destroy]
  resources :quotes, only: [:create, :destroy, :update, :edit]

  match '/notuleer/:id', to: 'meetings#notuleer', via: 'get'
  match '/dbdump', to: 'dbdump#show', via: 'get'
  match '/anonymize', to: 'dbdump#anonymize', via: 'get'
  match '/groups', to: 'usergroups#index', via: 'get'
  match '/register',  to: 'users#new',            via: 'get'
  match '/stats', to: 'static_pages#statistics', via: 'get'
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
      resources :signups, module: 'api2', only: [:index, :show, :update, :create]
      resources :stickers, module: 'api2', only: [:index, :show, :create]
      resources :reviews, module: 'api2', only: [:index, :show, :update, :create]
      resources :events, module: 'api2', only: [:index, :show, :update, :create]
      resources :motions, module: 'api2', only: [:index, :show, :update, :create]
      resources :nicknames, module: 'api2', only: [:index, :update, :create]
      get 'full_backup' => 'api2/backups#index'
      get 'whoami' => "api2/users#whoami"
      get 'changes' => 'api2/changes#index'
      post 'events/:id/remind' => 'api2/events#remind'
      post 'register' => "api2/api#register"
    end
  end
end
