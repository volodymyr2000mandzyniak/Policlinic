# spec/factories/doctors.rb
FactoryBot.define do
  factory :doctor do
    sequence(:first_name) { |n| "DoctorFirst#{n}" }
    sequence(:last_name) { |n| "DoctorLast#{n}" }
    sequence(:phone) { |n| "+38067#{1000000 + n}" } # Генерує +380671000001, +380671000002 і т.д.
    sequence(:email) { |n| "doctor#{n}@example.com" }

    date_of_birth { 30.years.ago }
    address { "123 Main Street" }
    password { "password123" }
    password_confirmation { "password123" }
    approved { true }

    association :category

    trait :with_photo do
      photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'doctor.jpg'), 'image/jpeg') }
    end

    trait :unapproved do
      approved { false }
    end
  end
end
