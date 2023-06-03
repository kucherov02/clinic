class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :full_name
      t.date :date_of_birth
      t.references :patient_card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
