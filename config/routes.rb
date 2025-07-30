Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "first_page#index"

  devise_for :doctors
  devise_for :patients

  [:patients, :doctors].each do |resource|
    resources resource, only: resource == :patients ? [:index, :show] : [:index, :show, :edit, :update, :destroy] do
      member do
        patch :update_photo
      end
    end
  end

  resources :appointments, except: [:new, :destroy] do
    collection do
      get :closed
      get :open
      get :my_open
      get :my_closed
    end
  end
end
