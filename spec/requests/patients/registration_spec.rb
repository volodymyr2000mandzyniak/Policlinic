# spec/requests/patients/registration_spec.rb
require 'rails_helper'

RSpec.describe "Patient registration", type: :request do
  describe "POST /patients" do
    it "registers a new patient" do
      expect {
        post patient_registration_path, params: {
          patient: {
            first_name: "Test",
            last_name: "Patient",
            date_of_birth: "1990-01-01",
            phone: "0501234567",
            password: "password123",
            password_confirmation: "password123",
            address: "Kyiv"
          }
        }
      }.to change(Patient, :count).by(1)

      follow_redirect!
      expect(response.body).to include("Test Patient")
    end
  end
end
