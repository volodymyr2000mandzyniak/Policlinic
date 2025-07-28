# spec/factories/patients.rb
FactoryBot.define do
  factory :patient do
    first_name { "John" }
    last_name  { "Doe" }
    date_of_birth { "1990-01-01" }
    phone { Faker::PhoneNumber.cell_phone }
    password { "password123" }
    password_confirmation { "password123" }
    address { "123 Some St" }
  end
end
