FactoryBot.define do
  factory :doctor do
    sequence(:first_name) { |n| "DoctorFirst#{n}" }
    sequence(:last_name) { |n| "DoctorLast#{n}" }
    sequence(:phone) { |n| "3805012345#{n.to_s.rjust(2, '0')}" }
    sequence(:email) { |n| "doctor#{n}@example.com" }

    date_of_birth { 30.years.ago }
    address { "123 Main Street" }
    password { "password123" }
    password_confirmation { "password123" }
    approved { true }

    association :category
  end
end
