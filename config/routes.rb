WaitForIt::Application.routes.draw do
  root :to => 'restaurants#index'
  resources :restaurants, only: [:new, :create, :index] do
    resources :reservations, only: [:update, :destroy, :index, :create, :show]
  end

  resources :sessions, only:[:create, :destroy]

  resources :messages, only: [:create]
end
