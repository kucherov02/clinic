require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'validations' do
    it 'is invalid without a name' do
      department = Department.new(number: 1, creation_date: Date.today, hospital: Hospital.new)
      expect(department).not_to be_valid
    end

    it 'is invalid without a number' do
      department = Department.new(name: 'Department', creation_date: Date.today, hospital: Hospital.new)
      expect(department).not_to be_valid
    end

    it 'is invalid without a creation date' do
      department = Department.new(name: 'Department', number: 1, hospital: Hospital.new)
      expect(department).not_to be_valid
    end

    it 'is invalid without a hospital' do
      department = Department.new(name: 'Department', number: 1, creation_date: Date.today)
      expect(department).not_to be_valid
    end

    it 'is valid with all required attributes' do
      hospital = Hospital.create(name: 'Hospital', address: '123 Main St', creation_date: Date.today)
      department = Department.new(name: 'Department', number: 1, creation_date: Date.today, hospital: hospital)
      expect(department).to be_valid
    end
  end
end
