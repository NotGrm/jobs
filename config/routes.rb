Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :bookings
    resources :listings
    resources :missions, only: :index
    resources :reservations
  end
end
