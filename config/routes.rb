WaitForIt::Application.routes.draw do
  root :to => 'reservations#index'
  resources :reservations, only: [:update, :destroy, :index, :create]
  resources :messages, only: [:new, :create]
end
