class PatientsController < ApplicationController
  before_action :authenticate_patient!

  def show
    @patient = current_patient
  end
end
