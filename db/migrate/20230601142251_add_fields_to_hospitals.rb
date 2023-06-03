class AddFieldsToHospitals < ActiveRecord::Migration[7.0]
  def change
    add_column :hospitals, :facility_type, :string
    add_column :hospitals, :city, :string
    add_column :hospitals, :mortality, :string
  end
end
