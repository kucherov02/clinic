require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe 'validations' do
    it 'is invalid without a full name' do
      hospital = Hospital.create(name: 'Hospital', address: '123 Main St', creation_date: Date.today)
      department = Department.create(name: 'Department', number: 1, creation_date: Date.today, hospital: hospital)
      doctor = Doctor.new(date_of_joining: Date.today, department: department)
      expect(doctor).not_to be_valid
    end

    it 'is invalid without a date of joining' do
      hospital = Hospital.create(name: 'Hospital', address: '123 Main St', creation_date: Date.today)
      department = Department.create(name: 'Department', number: 1, creation_date: Date.today, hospital: hospital)
      doctor = Doctor.new(full_name: 'John Doe', department: department)
      expect(doctor).not_to be_valid
    end

    it 'is invalid without a department' do
      doctor = Doctor.new(full_name: 'John Doe', date_of_joining: Date.today)
      expect(doctor).not_to be_valid
    end

    it 'is valid with all required attributes' do
      hospital = Hospital.create(name: 'Hospital', address: '123 Main St', creation_date: Date.today)
      department = Department.create(name: 'Department', number: 1, creation_date: Date.today, hospital: hospital)
      doctor = Doctor.new(full_name: 'John Doe', date_of_joining: Date.today, department: department)
      expect(doctor).to be_valid
    end
  end
end
