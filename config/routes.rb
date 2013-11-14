WaitForIt::Application.routes.draw do
  root :to => 'guests#index'
  resources :restaurants, only: [:new, :create, :index] do
    resources :reservations, only: [:update, :destroy, :index, :create, :show]
  end
  resources :guests, only: [:index, :new, :create, :show]

  resources :guestssessions, only: [:create, :destroy]
  resources :sessions, only:[:create, :destroy]

  post '/guests/:id/restaurants/:restaurant_id/reservations', to: 'guests#reservation_request', as: :guest_request
  get '/reservations/currentreservations', to: 'reservations#currentreservations', constraints: {format: /json/}
  get '/guests/:id/restaurants', to: 'guests#restaurants', as: :guest_restaurants
  post '/archive/:restaurant_id/:id', to: 'reservations#archive', as: :archive
  get '/guest/:restaurant_name', to: 'reservations#guest', as: :guest_waitlist
  post '/messages', to: 'reservations#messages', constraints: {format: /json/}
end