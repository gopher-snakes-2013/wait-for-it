WaitForIt::Application.routes.draw do
  root :to => 'reservations#index'

  resources :reservations, only: [:update, :destroy, :index, :create, :show]

  resources :restaurants, only: [:new, :create, :index]

  resources :sessions, only:[:create, :destroy]

  resources :messages, only: [:create]

end
