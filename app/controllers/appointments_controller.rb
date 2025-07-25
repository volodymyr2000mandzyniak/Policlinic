class AppointmentsController < ApplicationController
  load_and_authorize_resource except: [:closed, :my_open, :my_closed]

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient = current_patient if current_patient
    @appointment.status = 'open'

    if @appointment.save
      redirect_to doctor_path(@appointment.doctor), notice: "Запис успішно створено!"
    else
      redirect_to doctor_path(@appointment.doctor), alert: "Неможливо записатись до цього лікаря."
    end
  end

  def show
    # load_and_authorize_resource вже завантажить і перевірить доступ
  end

  def index
    if current_doctor
      @appointments = current_doctor.appointments.includes(:patient).where(status: 'open')
    elsif current_patient
      @appointments = current_patient.appointments.includes(:doctor)
    else
      redirect_to root_path, alert: "Доступ заборонено"
    end
  end


  def update
    if @appointment.update(appointment_params.merge(status: 'closed'))
      redirect_to appointments_path, notice: "Рекомендація надана, запис закрито"
    else
      redirect_to appointments_path, alert: "Помилка при оновленні"
    end
  end

  def closed
    authorize! :read, Appointment
    @appointments = current_doctor.appointments.includes(:patient).where(status: 'closed')
  end

  def my_open
    authorize! :read, Appointment
    @appointments = current_patient.appointments.includes(:doctor).where(status: 'open')
  end

  def my_closed
    authorize! :read, Appointment
    @appointments = current_patient.appointments.includes(:doctor).where(status: 'closed')
  end

  private

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :recommendation)
  end
end