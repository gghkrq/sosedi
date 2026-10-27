Rails.application.routes.draw do
  root "pages#home"

  resources :articles, only: [ :index ]

  get "404", to: "errors#not_found", as: :not_found

  get    "signup", to: "registrations#new",    as: :signup
  post   "signup", to: "registrations#create"
  get    "login",  to: "sessions#new",         as: :login
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy",     as: :logout

  resource :profile, only: [ :show, :edit, :update ]

  resources :favorites, only: [ :index ]

  resources :listings do
    get :my, on: :collection # /listings/my — "Мои объявления"
    resources :applications, only: [ :new, :create ]
    resource :favorite, only: [ :create, :destroy ]
  end

  resources :users, only: [ :show ]

  namespace :admin do
    root "dashboard#index"
    resources :users,        only: [ :index, :destroy ]
    resources :listings,     only: [ :index, :destroy ]
    resources :applications, only: [ :index ]
    resources :reviews,      only: [ :index, :destroy ]
    resources :reports,      only: [ :index, :update ]
    resources :articles,     except: [ :show ]
  end

  match "*path", to: "errors#not_found", via: :all, format: false,
                 constraints: ->(request) { !request.path.start_with?("/rails/") }
end
