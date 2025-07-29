# spec/factories/patients.rb
FactoryBot.define do
  factory :patient do
    first_name { "John" }
    last_name  { "Doe" }
    date_of_birth { "1990-01-01" }
    sequence(:phone) { |n| "+38050#{1000000 + n}" } # Генерує +380501000001, +380501000002 і т.д.
    password { "password123" }
    password_confirmation { "password123" }
    address { "123 Some St" }

    trait :with_photo do
      photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'patient.jpg'), 'image/jpeg') }
    end
  end
end