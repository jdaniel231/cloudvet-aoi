class CreateTicketItems < ActiveRecord::Migration[7.1]
  def change
    create_table :ticket_items do |t|
      t.references :ticket, null: false, foreign_key: true

      t.string :item_type, null: false   # 'service' or 'product'
      t.bigint :reference_id             # service_clinica.id OR products.id

      t.string :description, null: false
      t.integer :quantity, null: false, default: 1

      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :ticket_items, %i[item_type reference_id]
  end
end
