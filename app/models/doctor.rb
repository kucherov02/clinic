class Doctor < ApplicationRecord
  has_many :doctor_specialties
  has_many :specialties, through: :doctor_specialties
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients
  belongs_to :department

  validates :full_name, presence: true
  validates :date_of_joining, presence: true
end
