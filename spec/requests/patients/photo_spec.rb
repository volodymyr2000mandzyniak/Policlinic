# spec/requests/patients/photo_spec.rb
require 'rails_helper'

RSpec.describe "Patient photo update", type: :request do
  let(:patient) { create(:patient) }
  let(:test_photo_path) { Rails.root.join("spec/fixtures/files/avatar.jpg") }

  before do
    # Переконуємось, що тестовий файл існує
    unless File.exist?(test_photo_path)
      FileUtils.mkdir_p(test_photo_path.dirname)
      File.open(test_photo_path, 'wb') { |f| f.write(Base64.decode64("R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs=")) }
    end

    sign_in patient
  end

  it "updates the profile photo" do
    photo = fixture_file_upload(test_photo_path, "image/jpeg")

    expect {
      patch update_photo_patient_path(patient), params: {
        patient: { photo: photo }
      }
    }.to change { patient.reload.photo.attached? }.from(false).to(true)

    follow_redirect!
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Фото профілю успішно оновлено")
  end
end