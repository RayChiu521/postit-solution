PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/pin', to: 'sessions#pin'
  post '/pin', to: 'sessions#pin'


  resources :posts, except: [:destroy] do
  	member do
  		post '/vote', to: 'posts#vote'
  	end
  	resources :comments, only: [:create]
  end

  resources :comments, only: [] do
    member do
      post '/vote', to: 'comments#vote'
    end
  end

  resources :categories, only: [:show, :new, :create]
  resources :users, except: [:index]
end
