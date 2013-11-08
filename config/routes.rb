WaitForIt::Application.routes.draw do
  root to: "reservations#index"
  resources :reservations, only: [:index, :create]
end
