Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users/:id', to: 'users#show', as: "user"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :books do
    resources :reviews, only: [:index, :new, :create]
  end

  get '/books/top_rated/:number', to: "books#top_rated"
  
  scope '/admin' do
    resources :reviews, only: [:index]
  end

  resources :reviews, only: [:show, :edit, :update, :destroy]


end
