class AddToUserVaccines < ActiveRecord::Migration[7.1]
  def change
    add_column :vaccines, :user_id, :integer
  end
end
