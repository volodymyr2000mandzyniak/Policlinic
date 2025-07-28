require 'rails_helper'

RSpec.describe "Doctors Registration", type: :request do
  let(:category) { create(:category) }
  let(:valid_attributes) do
    {
      doctor: {
        email: "doctor@example.com",
        phone: "380501234567",
        category_id: category.id,
        password: "password123",
        password_confirmation: "password123",
        first_name: "Volodymyr",
        last_name: "Ivanov",
        date_of_birth: 30.years.ago.to_date.to_s,
        address: "123 Main Street"
      }
    }
  end

  describe "POST /doctors" do
    it "successfully registers a new doctor" do
      expect {
        post doctor_registration_path, params: valid_attributes
      }.to change(Doctor, :count).by(1)

      expect(response).to redirect_to(doctor_path(Doctor.last))
      follow_redirect!
      expect(response.body).to include(Doctor.last.full_name)
    end

    it "fails registration with invalid params" do
      invalid_attrs = valid_attributes.deep_dup
      invalid_attrs[:doctor][:phone] = ""

      expect {
        post doctor_registration_path, params: invalid_attrs
      }.not_to change(Doctor, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('field_with_errors')
      expect(response.body).to include('Phone can&#39;t be blank')
    end
  end
end