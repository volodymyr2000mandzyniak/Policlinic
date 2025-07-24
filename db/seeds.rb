# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


categories = [
  "Терапевт",
  "Стоматолог",
  "Хірург",
  "Педіатр",
  "Кардіолог",
  "Офтальмолог",
  "Невролог"
]

categories.each do |title|
  Category.find_or_create_by!(title: title)
end

puts "✅ Categories seeded successfully!"


require 'faker'

Doctor.destroy_all

puts "Створюємо лікарів для кожної категорії..."

Category.find_each do |category|
  rand(2..6).times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    phone = Faker::PhoneNumber.unique.cell_phone_in_e164
    email = Faker::Internet.unique.email(name: "#{first_name}.#{last_name}")

    Doctor.create!(
      email: email,
      phone: phone,
      password: "password123",
      password_confirmation: "password123",
      first_name: first_name,
      last_name: last_name,
      date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 60),
      address: Faker::Address.full_address,
      category_id: category.id
    )
  end

  puts "✔ Створено лікарів для категорії: #{category.title}"
end

puts "✅ Готово!"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?