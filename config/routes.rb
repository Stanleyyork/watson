Rails.application.routes.draw do

  root to: 'application#homepage'
  get '/' => 'application#homepage'
  get '/about' => 'application#about'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  patch '/:id' => 'users#update'
  post '/users' => 'users#create'
  patch '/:id' => 'users#update'

  get '/books' => 'channels#booksIndex'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/facebook' => 'application#facebook'
  get '/settings' => 'users#edit', as: 'edit_user'
  post '/twitter' => 'users#twitter'
  get '/facebookpostsretrieval' => 'users#facebook', as: 'facebook_posts_retreival'
  get '/analyzedata' => 'users#analyze_personality', as: 'analyze_data'

  get '/:username' => 'users#show', as: 'user'

  resources :sessions, only: [:create, :destroy]
  resources :users
end
