# spec/requests/patients/login_spec.rb
require 'rails_helper'

RSpec.describe "Patient login", type: :request do
  let(:patient) { create(:patient, phone: "+380501234567", password: "password123") }

  it "logs in the patient" do
    post patient_session_path, params: {
      patient: {
        phone: patient.phone,
        password: "password123"
      }
    }

    expect(response).to redirect_to(patient_path(patient))
    follow_redirect!
    expect(response.body).to include(patient.full_name)
  end
end
