# spec/requests/patients/update_spec.rb
require 'rails_helper'

RSpec.describe "Patient profile update", type: :request do
  let(:patient) { create(:patient, first_name: "Old") }

  before { sign_in patient }

  it "updates first name" do
    patch patient_registration_path, params: {
      patient: {
        first_name: "New",
        current_password: "password123"
      }
    }

    follow_redirect!
    expect(response.body).to include("New")
  end
end
