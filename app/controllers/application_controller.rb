# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  before_action :configure_permitted_parameters, if: :devise_controller?

  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end


  protected

  def current_ability
  @current_ability ||= Ability.new(current_admin_user || current_doctor || current_patient)
end


  def configure_permitted_parameters
    params = permitted_devise_params
    return unless params.present?

    devise_parameter_sanitizer.permit(:sign_up, keys: params)
    devise_parameter_sanitizer.permit(:account_update, keys: params)
  end

  def after_sign_in_path_for(resource)
    path_for(resource)
  end

  def after_sign_up_path_for(resource)
    path_for(resource)
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

    def path_for(resource)
    return doctor_path(resource) if resource.is_a?(Doctor)
    return patient_path(resource) if resource.is_a?(Patient)

    root_path
  end
end
