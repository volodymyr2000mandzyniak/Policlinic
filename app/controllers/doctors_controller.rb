class DoctorsController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
    @doctors = if params[:category_id].present?
                Doctor.where(category_id: params[:category_id]).approved
    else
                Doctor.approved
    end
  end

  def show
    @appointments = @doctor.appointments.includes(:patient)
  end
end
