class PatientCard < ApplicationRecord
  has_one :patient

  validates :card_number, presence: true
end
