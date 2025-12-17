class AddIndexToClientsCpf < ActiveRecord::Migration[7.1]
  def change
    add_index :clients, :cpf, unique: true
  end
end
