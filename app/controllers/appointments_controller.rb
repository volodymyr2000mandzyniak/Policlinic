class AppointmentsController < ApplicationController
  load_and_authorize_resource except: [:closed, :my_open, :my_closed]

def create
  @appointment = Appointment.new(appointment_params)
  @appointment.patient = current_patient
  @appointment.status = 'open'

  if @appointment.save
    redirect_to doctor_path(@appointment.doctor), notice: "Запис успішно створено!"
  else
    redirect_to doctor_path(@appointment.doctor), 
                alert: "Помилка: #{@appointment.errors.full_messages.join(', ')}"
  end
end


  def index
    if current_doctor
      @appointments = current_doctor.appointments.includes(:patient)
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
      render :edit
    end
  end

  def closed
    authorize! :read, Appointment
    @appointments = current_doctor.appointments.closed.includes(:patient)
    render :index
  end

  def my_open
    authorize! :read, Appointment
    @appointments = current_patient.appointments.open.includes(:doctor)
    render :index
  end

  def my_closed
    authorize! :read, Appointment
    @appointments = current_patient.appointments.closed.includes(:doctor)
    render :index
  end

  private

  def appointment_params
  params.require(:appointment).permit(:doctor_id, :recommendation)
  end
end