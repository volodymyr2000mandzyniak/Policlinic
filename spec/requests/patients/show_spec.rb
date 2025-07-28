# spec/requests/patients/show_spec.rb
require 'rails_helper'

RSpec.describe "Patient profile", type: :request do
  let(:patient) { create(:patient) }

  before do
    sign_in patient
  end

  it "displays patient's profile and appointments" do
    get patient_path(patient)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(patient.full_name)
  end
end
