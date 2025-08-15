class VaccineType < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end

  def un_delete
    update(deleted_at: nil)
  end

  def destroy
    soft_delete
  end
end