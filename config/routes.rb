Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "first_page#index"

  devise_for :doctors
  devise_for :patients

  resources :patients, only: [ :index, :show ], controller: "patients"
  resources :doctors,  only: [ :index, :show ], controller: "doctors"

  resources :appointments, except: [:new, :destroy] do
  collection do
    get :closed
    get :my_open
    get :my_closed
  end
end

end