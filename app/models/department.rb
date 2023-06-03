class Department < ApplicationRecord
  belongs_to :hospital
  has_many :doctors
  has_many :patients, through: :doctors

  validates :name, presence: true
  validates :number, presence: true
  validates :creation_date, presence: true
end
