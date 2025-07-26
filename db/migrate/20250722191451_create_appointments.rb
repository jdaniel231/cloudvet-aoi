class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.text :chief_complaint
      t.text :medical_history
      t.text :suspected_exams
      t.references :animal, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
