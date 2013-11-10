WaitForIt::Application.routes.draw do
  root :to => 'restaurants#index'
  resources :restaurants, only: [:new, :create, :index] do
    resources :reservations, only: [:update, :destroy, :index, :create, :show]
  end
  resources :sessions, only:[:create, :destroy]
  post 'reservations/updatetime', to: 'reservations#update_wait_time'
end
