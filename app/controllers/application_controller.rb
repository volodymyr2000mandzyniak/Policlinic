# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    params = permitted_devise_params
    return unless params.present?

    devise_parameter_sanitizer.permit(:sign_up, keys: params)
    devise_parameter_sanitizer.permit(:account_update, keys: params)
  end

  private

  def permitted_devise_params
    case resource_class.to_s
    when 'Doctor'
      base_params + [:category_id]
    when 'Patient'
      base_params
    else
      nil
    end
  end

  def base_params
    [
      :email, :first_name, :last_name, :date_of_birth, :address,
      :phone, :password, :password_confirmation
    ]
  end
end
