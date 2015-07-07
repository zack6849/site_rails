Rails.application.routes.draw do
  root 'index#welcome'
  resources :posts

  get 'gmod/show' => 'gmod#show'

  get 'uploader/' => 'uploader#get'
  post 'uploader/' => 'uploader#upload'

  #auth routing
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/gmod/' => 'gmod#show'
end