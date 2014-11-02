Hamers::Application.routes.draw do
  resources :motions

  resources :public_pages

  resources :meetings

  resources :beers do
    member do
      get :reviews
    end
  end

  resources :events

  resources :votes

  resources :polls
  resources :signups

  root  'static_pages#home'  

  resources :users do 
    member do
      get :usergroups
    end
  end
 
  resources :reviews, only: [:create, :destroy, :update, :edit]
  resources :groups, only: [:create, :destroy]
  resources :usergroups, only: [:create, :destroy]
  resources :quotes, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

	match '/notuleer/:id', to: 'meetings#notuleer', via: 'get'
	match '/dbdump', to: 'dbdump#show', via: 'get'
  match '/groups', to: 'usergroups#index', via: 'get'
  match '/register',  to: 'users#new',            via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete' 
	match '/:id', to: 'public_pages#show', via: 'get'
end
