class RemoveDoctorIdFromSpecialties < ActiveRecord::Migration[7.0]
  def change
    remove_reference :specialties, :doctor, index: true, foreign_key: true
  end
end
