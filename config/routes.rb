Hamers::Application.routes.draw do
  use_doorkeeper
  get 'switch_user', to: 'switch_user#set_current_user'
  get 'switch_user/remember_user', to: 'switch_user#remember_user'
  get 'privacy' => 'static_pages#privacy'
  get 'activate_account' => 'static_pages#activate_account', as: "activate_account"

  resources :notes
  resources :pushes, only: [:index, :show, :create, :new]
  resources :stickers
  resources :recipe, path: "recipes" do
    member do
      resources :brews, except: [:index]
    end
  end
  get '/mystickers' => 'stickers#personal', as: 'personal_sticker'

  resources :news
  get '/images' => 'albums#index', as: 'photo'
  get '/trail' => 'static_pages#trail' , as: 'trail'
  get '/trail' => 'static_pages#trail' , as: 'device'
  get '/quotes/:id' => 'static_pages#quote', as: 'quote'
  get '/remind/:id' => 'events#remind', as: 'reminder'

  match '/webconsole', to: 'static_pages#console', via: 'get'
  resources :motions
  resources :api_keys, only: [:create, :show, :destroy]
  resources :public_pages, except: [:show]
  get '/public_pages/:id' => 'public_pages#find_id'
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

  resources :events do
    member do
      get '/public_signup' => "external_signups#new", as: "new_external_signup"
      post '/public_signup' => "external_signups#create", as: "create_external_signup"
      get '/see_you_soon' => "external_signups#see_you_soon", as: "see_you_soon"
    end
  end
  get '/ical/:key' => "events#index"
  get '/ical/:key/cal' => "events#index"

  resources :signups

  root 'static_pages#home'

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
  match '/admin_accounts', to: 'users#admin', via: 'get', as: 'leden_admin'
  match '/admin_accounts/:id', to: 'users#admin_patch', via: 'patch', as: 'leden_admin_update'

  get 'leden', to: "users#index_public", as: "public_leden"

  resources :reviews, only: [:show, :create, :destroy, :update, :edit]
  resources :groups, only: [:create, :destroy]
  resources :usergroups, only: [:create, :destroy]
  resources :quotes, only: [:create, :destroy, :update, :edit]

  match '/notuleer/:id', to: 'meetings#notuleer', via: 'get'
  match '/dbdump', to: 'dbdump#show', via: 'get'
  match '/anonymize', to: 'dbdump#anonymize', via: 'get'
  match '/groups', to: 'usergroups#index', via: 'get'
  match '/register',  to: 'users#new', via: 'get'
  match '/:id', to: 'public_pages#show', via: 'get'
  scope 'endpoints' do
    get 'email' => 'endpoints/email#create'
  end
end
