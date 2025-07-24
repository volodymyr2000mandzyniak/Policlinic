Rails.application.routes.draw do
  root "first_page#index"

  devise_for :doctors
  devise_for :patients

  resources :patients, only: [ :index, :show ], controller: "patients"
  resources :doctors,  only: [ :index, :show ], controller: "doctors"
end
