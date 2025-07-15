class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :cpf
      t.string :rg
      t.string :phone
      t.string :address
      t.string :number_address
      t.string :compl_address
      t.string :neighborhoods

      t.timestamps
    end
  end
end
