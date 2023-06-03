require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'validations' do
    it 'is invalid without a full name' do
      patient = Patient.new(date_of_birth: Date.today, patient_card_id: 1)
      expect(patient).not_to be_valid
    end

    it 'is invalid without a date of birth' do
      patient = Patient.new(full_name: 'John Doe', patient_card_id: 1)
      expect(patient).not_to be_valid
    end

    it 'is invalid without a patient card' do
      patient = Patient.new(full_name: 'John Doe', date_of_birth: Date.today)
      expect(patient).not_to be_valid
    end

    it 'is valid with all required attributes' do
      patient_card = PatientCard.create(card_number: '123456789')
      patient = Patient.new(full_name: 'John Doe', date_of_birth: Date.today, patient_card_id: patient_card.id)
      expect(patient).to be_valid
    end
  end
end
