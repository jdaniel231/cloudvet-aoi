class CreateAnimals < ActiveRecord::Migration[7.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :age
      t.string :sex
      t.string :species
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
