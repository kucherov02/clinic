class CreateHospitalDoctorsCountView < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE VIEW hospital_doctors_count AS 
      SELECT hospitals.name AS hospital_name, COUNT(doctors.id) AS doctor_count
      FROM hospitals
      LEFT JOIN departments ON hospitals.id = departments.hospital_id
      LEFT JOIN doctors ON departments.id = doctors.department_id
      GROUP BY hospitals.id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS hospital_doctors_count
    SQL
  end
end
