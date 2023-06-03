class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :full_name
      t.date :date_of_joining
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
