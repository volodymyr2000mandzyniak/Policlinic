require 'rails_helper'

RSpec.describe "Doctors show", type: :request do
  let(:doctor) { create(:doctor) }
  let(:other_doctor) { create(:doctor) }

  before { sign_in doctor }

  it "shows own profile" do
    get doctor_path(doctor)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(doctor.first_name)
  end

  it "shows another doctor's profile" do
    get doctor_path(other_doctor)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(other_doctor.first_name)
  end
end
