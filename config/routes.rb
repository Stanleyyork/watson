Rails.application.routes.draw do

  get '/' => 'application#homepage'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/books' => 'channels#booksIndex'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/facebook' => 'application#facebook'
  get '/users/:id/edit' => 'users#edit'
  post '/edit' => 'users#twitter'

  resources :sessions, only: [:create, :destroy]
  resources :users
end
