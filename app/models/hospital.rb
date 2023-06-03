class Hospital < ApplicationRecord
  self.inheritance_column = :_type_disabled

  has_many :departments
  has_many :doctors, through: :departments
  has_many :patients, through: :doctors

  validates :name, presence: true
  validates :address, presence: true
  validates :creation_date, presence: true

  attribute :facility_type, :string
  attribute :city, :string
  attribute :mortality, :string

  def self.parse_csv
    require 'csv'

    csv_text = File.read('app/assets/csv/hospitals.csv')
    csv = CSV.parse(csv_text, headers: true)

    threads = []
    mutex = Mutex.new

    csv.each_slice(100) do |rows|
      threads << Thread.new do
        rows.each do |row|
          hospital = Hospital.new
          hospital.name = row['Facility.Name']
          hospital.address = row['Facility.City']
          hospital.creation_date = Faker::Date.backward(days: 365)
          hospital.facility_type = row['Facility.Type']
          hospital.city = row['Facility.City']
          hospital.mortality = row['Rating.Mortality']
          mutex.synchronize { hospital.save }
        end
      end
    end

    threads.each(&:join)
  end

  def self.to_csv
    attributes = %w[name address creation_date facility_type city mortality patient_name patient_date_of_birth]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.left_outer_joins(doctors: :patients)
         .select('hospitals.name, hospitals.address, hospitals.creation_date, hospitals.facility_type, hospitals.city, hospitals.mortality, patients.full_name AS patient_name, patients.date_of_birth AS patient_date_of_birth')
         .each do |hospital|
        csv << hospital.attributes.values_at(*attributes)
      end
    end
  end
end
