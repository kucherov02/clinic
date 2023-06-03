class CreateDoctorPatientsCountView < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE VIEW doctor_patients_count AS 
      SELECT doctors.full_name, COUNT(doctor_patients.patient_id) AS patient_count
      FROM doctors
      LEFT JOIN doctor_patients ON doctors.id = doctor_patients.doctor_id
      GROUP BY doctors.id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS doctor_patients_count
    SQL
  end
end
