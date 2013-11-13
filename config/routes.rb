WaitForIt::Application.routes.draw do
  root :to => 'guests#index'
  resources :restaurants, only: [:new, :create, :index] do
    resources :reservations, only: [:update, :destroy, :index, :create, :show]
  end
  resources :sessions, only:[:create, :destroy]
  resources :guests, only: [:index]

  post '/archive/:restaurant_id/:id', to: 'reservations#archive', as: :archive
  get '/guest/:restaurant_name', to: 'reservations#guest', as: :guest_waitlist
  get '/reservations/currentreservations', to: 'reservations#currentreservations', constraints: {format: /json/}
  post '/messages', to: 'reservations#messages', constraints: {format: /json/}
end