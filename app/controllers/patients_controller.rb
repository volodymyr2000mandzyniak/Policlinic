class PatientsController < ApplicationController
  before_action :authenticate_patient!

  def show
    @patient = current_patient
    @appointments = @patient.appointments.includes(:doctor).order(created_at: :desc)
  end
end
