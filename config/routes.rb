Rails.application.routes.draw do
  root "listings#index"

  resources :listings do
    resources :applications, only: [:new, :create]
  end

  resources :users, only: [:index, :show]
end
