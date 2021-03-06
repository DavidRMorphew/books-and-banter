Rails.application.routes.draw do

  root "static#home"

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users/:id', to: 'users#show', as: "user"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#omniauth'

  resources :books do
    resources :reviews, only: [:index, :new, :create]
    resources :checkouts, only: [:create, :update]
  end

  resources :checkouts, only: [:index]

  scope '/admin' do
    resources :reviews, only: [:index]
  end

  resources :reviews, only: [:show, :edit, :update, :destroy]

end
