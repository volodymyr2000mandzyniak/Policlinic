class PatientsController < ApplicationController
  load_and_authorize_resource

  def show
    @appointments = @patient.appointments.includes(:doctor).order(created_at: :desc)
  end
end