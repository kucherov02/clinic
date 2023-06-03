class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
  belongs_to :patient_card

  validates :full_name, presence: true
  validates :date_of_birth, presence: true
end
