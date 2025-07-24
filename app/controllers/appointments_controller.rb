class AppointmentsController < ApplicationController
  before_action :authenticate_patient!, only: [:create]
  before_action :authenticate_doctor!, only: [:index, :update]

  # Пацієнт записується на прийом
  def create
    doctor = Doctor.find(params[:doctor_id])

    if doctor.approved? && doctor.can_accept_new_appointment?
      appointment = current_patient.appointments.create(doctor: doctor)
      redirect_to doctor_path(doctor), notice: "Запис успішно створено!"
    else
      redirect_to doctor_path(doctor), alert: "Неможливо записатись до цього лікаря."
    end
  end

  # GET /appointments/:id
def show
  @appointment = current_patient.appointments.find(params[:id])
end


  # Лікар бачить свої відкриті записи
  def index
    @appointments = current_doctor.appointments.includes(:patient).where(status: 'open')
  end

  # GET /appointments/:id/edit
def edit
  @appointment = current_doctor.appointments.find(params[:id])
end


  def update
  appointment = current_doctor.appointments.find(params[:id])
  if appointment.update(appointment_params.merge(status: 'closed'))
    redirect_to appointments_path, notice: "Рекомендація надана, запис закрито"
  else
    redirect_to appointments_path, alert: "Помилка при оновленні"
  end
end

private

def appointment_params
  params.require(:appointment).permit(:recommendation)
end

end
