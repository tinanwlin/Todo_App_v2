Rails.application.routes.draw do
  root to: 'todos#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
