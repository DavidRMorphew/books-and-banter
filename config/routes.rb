Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users/:id', to: 'users#show', as: "user"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

  resources :books do
    resources :reviews, only: [:index, :new, :create]
  end

  get '/books/most_reviewed/:number', to: "books#most_reviewed"
  
  scope '/admin' do
    resources :reviews, only: [:index]
  end

  resources :reviews, only: [:show, :edit, :update, :destroy]


end
