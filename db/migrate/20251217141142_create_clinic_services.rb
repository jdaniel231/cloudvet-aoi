class CreateClinicServices < ActiveRecord::Migration[7.1]
  def change
    create_table :clinic_services do |t|
      t.string :name
      t.decimal :cost_value
      t.decimal :total_value

      t.timestamps
    end
  end
end
