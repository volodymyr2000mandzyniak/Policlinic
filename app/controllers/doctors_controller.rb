class DoctorsController < ApplicationController
  before_action :authenticate_doctor!

  def show
    @doctor = current_doctor
  end
end
