Rails.application.routes.draw do
  root "first_page#index"

  devise_for :doctors
  devise_for :patients

  resources :patients, only: [ :show ], controller: "patients"
  resources :doctors, only: [ :show ], controller: "doctors"
end
