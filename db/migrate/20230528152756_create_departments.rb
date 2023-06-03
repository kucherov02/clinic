class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :number
      t.date :creation_date
      t.references :hospital, null: false, foreign_key: true

      t.timestamps
    end
  end
end
