class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :animal

  enum :payment_status, { pending: 'pending', paid: 'paid', cancelled: 'cancelled' }, default: 'pending'

  validates :payment_status, presence: true

  has_many :ticket_items, dependent: :destroy
  accepts_nested_attributes_for :ticket_items, allow_destroy: true

  def recalculate_totals!
    subtotal_val = ticket_items.sum(:total_price)

    update!(
      subtotal: subtotal_val,
      total_amount: subtotal_val - (discount || 0) + (surcharge || 0)
    )
  end
end
