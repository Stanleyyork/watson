Rails.application.routes.draw do
  
  get 'personality_dual_descriptions/new'

  get 'personality_descriptions/new'
  post 'personality_descriptions' => 'personality_descriptions#create'

  get '/' => 'application#homepage'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/books' => 'channels#booksIndex'
  get '/personalities/new' => 'personalities#new'

  resources :users
end
