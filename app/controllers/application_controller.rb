# # app/controllers/application_controller.rb
# class ApplicationController < ActionController::Base
#   include CanCan::ControllerAdditions

#   before_action :configure_permitted_parameters, if: :devise_controller?

#   include CanCan::ControllerAdditions

#   rescue_from CanCan::AccessDenied do |exception|
#     redirect_to root_url, alert: exception.message
#   end

#   def update_photo
#     resource = controller_name.classify.constantize.find(params[:id])
    
#     if resource.update(photo_params)
#       redirect_to resource, notice: 'Фото профілю успішно оновлено'
#     else
#       redirect_to resource, alert: 'Не вдалося оновити фото'
#     end
#   end

#   protected

#   def current_ability
#     @current_ability ||= Ability.new(current_admin_user || current_doctor || current_patient)
#   end

#   def configure_permitted_parameters
#     params = permitted_devise_params
#     return unless params.present?

#     devise_parameter_sanitizer.permit(:sign_up, keys: params)
#     devise_parameter_sanitizer.permit(:account_update, keys: params)
#   end

#   def after_sign_in_path_for(resource)
#     path_for(resource)
#   end

#   def after_sign_up_path_for(resource)
#     path_for(resource)
#   end

#   private

#     def photo_params
#     params.require(controller_name.singularize.to_sym).permit(:photo)
#   end

#   def permitted_devise_params
#     case resource_class.to_s
#     when 'Doctor'
#       base_params + [:category_id]
#     when 'Patient'
#       base_params
#     else
#       nil
#     end
#   end

#   def base_params
#     [
#       :email, :first_name, :last_name, :date_of_birth, :address,
#       :phone, :password, :password_confirmation, :photo
#     ]
#   end

#   def path_for(resource)
#     return doctor_path(resource) if resource.is_a?(Doctor)
#     return patient_path(resource) if resource.is_a?(Patient)
#     root_path
#   end
# end





class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied, with: :handle_access_denied

  BASE_PARAMS = [
    :email, :first_name, :last_name, :date_of_birth, :address,
    :phone, :password, :password_confirmation, :photo
  ].freeze

  def update_photo
    resource = controller_name.classify.constantize.find(params[:id])

    if resource.update(photo_params)
      redirect_to resource, notice: 'Фото профілю успішно оновлено'
    else
      redirect_to resource, alert: 'Не вдалося оновити фото'
    end
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

  def handle_access_denied(exception)
    redirect_to root_url, alert: exception.message
  end

  def photo_params
    params.require(controller_name.singularize.to_sym).permit(:photo)
  end

  def permitted_devise_params
    case resource_class.to_s
    when 'Doctor'
      BASE_PARAMS + [:category_id]
    when 'Patient'
      BASE_PARAMS
    else
      nil
    end
  end

  def path_for(resource)
    case resource
    when Doctor then doctor_path(resource)
    when Patient then patient_path(resource)
    else root_path
    end
  end
end
