# db/seeds.rb

# Очищаємо дані (у правильному порядку для уникнення помилок foreign key)
Appointment.destroy_all
Patient.destroy_all
Doctor.destroy_all
Category.destroy_all

puts "🔄 Очищення бази даних..."

# Створення категорій
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

puts "✅ Категорії створені успішно!"

# Створення лікарів
puts "Створюємо лікарів для кожної категорії..."

Category.find_each do |category|
  rand(2..4).times do
    Doctor.create!(
      email: Faker::Internet.unique.email,
      phone: "+380#{rand(50..99)}#{rand(1_000_000..9_999_999)}", # Формат +380XXXXXXXXX
      password: "password123",
      password_confirmation: "password123",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 60),
      address: Faker::Address.full_address,
      category: category,
      approved: true
    )
  end
  puts "✔ Створено #{Doctor.where(category: category).count} лікарів для категорії: #{category.title}"
end

puts "✅ Лікарі створені успішно!"

# Створення пацієнтів
puts "Створюємо пацієнтів..."

10.times do |n|
  Patient.create!(
    email: Faker::Internet.unique.email,
    phone: "+38050#{1000000 + n}", # Унікальні номери у форматі +38050XXXXXXX
    password: "password123",
    password_confirmation: "password123",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 90),
    address: Faker::Address.full_address
  )
end

puts "✅ Пацієнти створені успішно!"

# # Створення записів на прийом
# puts "Створюємо записи на прийом..."

# doctors = Doctor.all
# patients = Patient.all

# 20.times do
#   doctor = doctors.sample
#   patient = patients.sample
  
#   if doctor.can_accept_new_appointment?
#     appointment = Appointment.create!(
#       doctor: doctor,
#       patient: patient,
#       status: ['open', 'closed'].sample,
#       recommendation: Faker::Lorem.sentence(word_count: 5) # Використовуємо однину (recommendation)
#     )
    
#     puts "✔ Запис створено: #{appointment.id} - Лікар: #{doctor.full_name}, Пацієнт: #{patient.full_name}"
#   else
#     puts "⚠ Лікар #{doctor.full_name} вже має максимальну кількість записів"
#   end
# end

# puts "✅ Записи на прийом створені успішно!"

# Створення адміністратора
admin_email = ENV.fetch('ADMIN_EMAIL', 'admin@example.com')
admin_password = ENV.fetch('ADMIN_PASSWORD', 'password')

AdminUser.find_or_create_by!(email: admin_email) do |admin|
  admin.password = admin_password
  admin.password_confirmation = admin_password
end

puts "✅ Адміністратор створений (#{admin_email} / #{admin_password})"



puts "🎉 Базу даних успішно заповнено тестовими даними!"