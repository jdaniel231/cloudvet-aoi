class CreateVaccines < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccines do |t|
      t.references :animal, null: false, foreign_key: true
      t.references :vaccine_type, null: false, foreign_key: true
      t.date :application_date
      t.date :return_date
      t.string :applied_dose
      t.text :obs

      t.timestamps
    end
  end
end
