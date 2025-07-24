class DoctorsController < ApplicationController
  def index
    @categories = Category.all
    @doctors = if params[:category_id].present?
                Doctor.where(category_id: params[:category_id])
    else
                Doctor.all
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
    @appointments = @doctor.appointments.includes(:patient)

    unless @doctor.approved? || current_doctor == @doctor
      redirect_to root_path, alert: "Профіль лікаря ще не підтверджено."
    end
  end
end
