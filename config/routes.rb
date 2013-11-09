WaitForIt::Application.routes.draw do
  root :to => 'restaurants#index'
  resources :restaurants, only: [:new, :create, :index] do
    resources :reservations, only: [:update, :destroy, :index, :create, :show]
  end

  resources :sessions, only:[:create, :destroy]


  resources :messages, only: [:create]

  get '/reservations/:restaurant_id/list.:format', to: 'reservations#api', as: :reservations_api, constraints: {format: /json/}

end
