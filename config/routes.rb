Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :bookings
    resources :listings
  end
end
