Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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

  scope '/admin' do
    resources :reviews, only: [:index]
  end

  resources :reviews, only: [:show, :edit, :update, :destroy]

  # # nested route books/:book_id/checkouts
  # post '/checkouts/:id', to: 'checkouts#create'

end
