class CreateVaccineTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccine_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
