class RenamePortugueseColumnsInTickets < ActiveRecord::Migration[7.1]
  def change
    rename_column :tickets, :desconto, :discount
    rename_column :tickets, :acrescimo, :surcharge
    rename_column :tickets, :valor_total, :total_amount
    rename_column :tickets, :status_pagamento, :payment_status
    rename_column :tickets, :forma_pagamento, :payment_method
    rename_column :tickets, :data_pagamento, :payment_date
  end
end
