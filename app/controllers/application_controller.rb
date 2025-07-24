# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Налаштування дозволених параметрів
  def configure_permitted_parameters
    if resource_class == Doctor
      devise_parameter_sanitizer.permit(:sign_up, keys: doctor_params)
      devise_parameter_sanitizer.permit(:account_update, keys: doctor_params)
    elsif resource_class == Patient
      devise_parameter_sanitizer.permit(:sign_up, keys: patient_params)
      devise_parameter_sanitizer.permit(:account_update, keys: patient_params)
    end
  end

  private

  def doctor_params
    [:email, :first_name, :last_name, :date_of_birth, :address, :phone, :category_id, 
    :password, :password_confirmation]
  end

  def patient_params
    [:email, :first_name, :last_name, :date_of_birth, :address, :phone, 
    :password, :password_confirmation]
  end
end