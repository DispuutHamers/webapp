Hamers::Application.routes.draw do
  use_doorkeeper
  get 'privacy' => 'static_pages#privacy'
  get 'activate_account' => 'static_pages#activate_account', as: "activate_account"

  resources :stickers
  resources :recipes do
    member do
      resources :brews, except: [:index]
    end
  end
  get '/mystickers' => 'stickers#personal', as: 'personal_stickers'

  resources :news
  resources :blogitems, path: 'blog' do
    collection do
      get 'tag/:tag' => 'blogitems#tag', as: 'blog_by_tag'
    end
  end

  get '/trail' => 'static_pages#trail', as: 'trail'
  get '/remind/:id' => 'events#remind', as: 'reminder'
  resources :public_pages, except: [:show]
  get '/public_pages/:id' => 'public_pages#find_id'
  post 'revert/:model/:id' => "static_pages#revert"

  resources :meetings do
    member do
      get '/notuleer' => 'meetings#notuleer', as: 'notuleer'
    end
  end

  resources :beers do
    member do
      get :reviews
    end
    collection do
      get :table
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

  resources :signups, except: %i[index new edit]
  resources :usergroups, path: 'groups'

  root 'static_pages#home'

  devise_for :users
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new', as: "signin"
  end

  resources :users do
    resources :api_keys do
      get '/edit/api_keys/' => "api_keys#index"
      post '/edit/api_keys/new' => "api_keys#create", as: "api_key"
    end
    member do
      get '/edit/password/' => "users#edit_password", as: "edit_password"
      get 'edit/usergroups/' => "users#edit_usergroups", as: "edit_usergroups"
      get '/edit/two_factor' => "users#edit_two_factor", as: "edit_two_factor"
      post '/edit/two_factor' => "users#update_two_factor", as: "update_two_factor"
    end
  end

  resource :user, only: [:edit] do
    collection do
      patch 'update_password' => "users#update_password"
    end
  end

  get 'leden', to: "users#index_public", as: "public_leden"
  resources :reviews, only: [:show, :create, :destroy, :update, :edit]
  resources :groups, only: [:create, :destroy], path: 'group_members'
  resources :quotes

  resources :chug_types do
    member do
      resources :chugs, except: [:index]
    end
  end

  match '/register', to: 'users#new', via: 'get'
  match '/:id', to: 'public_pages#show', via: 'get'
end
