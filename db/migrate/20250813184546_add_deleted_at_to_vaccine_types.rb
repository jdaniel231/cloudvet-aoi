class AddDeletedAtToVaccineTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :vaccine_types, :deleted_at, :datetime
  end
end
