# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# using ORM
# Hospitals
100.times do
  Hospital.create(name: Faker::Company.name, creation_date: Faker::Date.backward(days: 365), address: Faker::Address.full_address)
end

# Departments
100.times do |i|
  Department.create(name: "Department #{i}", number: i, creation_date: Faker::Date.backward(days: 365), hospital_id: Hospital.pluck(:id).sample)
end

# Specialities
100.times do
  Specialty.create(name: Faker::Job.seniority)
end

# Doctors
100.times do
  doctor = Doctor.new(full_name: Faker::Name.name, date_of_joining: Faker::Date.backward(days: 365), department_id: Department.pluck(:id).sample)
  doctor.specialties << Specialty.order(Arel.sql('RAND()')).first # or Specialty.all.sample
  unless doctor.save
    puts "Failed to save doctor: #{doctor.errors.full_messages.join(", ")}"
  end
end

# Patient cards
100.times do
  PatientCard.create(card_number: Faker::Finance.credit_card(:mastercard))
end

# Patients
100.times do
  Patient.create(full_name: Faker::Name.name, date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65), patient_card_id: PatientCard.pluck(:id).sample)
end

# DoctorPatient
100.times do
  DoctorPatient.create(doctor_id: Doctor.pluck(:id).sample, patient_id: Patient.pluck(:id).sample)
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?