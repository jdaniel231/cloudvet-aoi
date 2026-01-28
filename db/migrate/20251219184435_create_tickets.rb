class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :animal, null: false, foreign_key: true

      t.decimal :subtotal, precision: 10, scale: 2, null: false, default: 0
      t.decimal :desconto, precision: 10, scale: 2, default: 0
      t.decimal :acrescimo, precision: 10, scale: 2, default: 0
      t.decimal :valor_total, precision: 10, scale: 2, null: false, default: 0

      t.string :status_pagamento, default: 'pendente'
      t.string :forma_pagamento
      t.datetime :data_pagamento

      t.timestamps
    end
  end
end
