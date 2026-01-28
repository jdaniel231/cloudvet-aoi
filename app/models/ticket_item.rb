class TicketItem < ApplicationRecord
  belongs_to :ticket

  validates :item_type, inclusion: { in: %w[service product] }
  validates :description, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_defaults
  before_validation :set_service_details, if: -> { item_type == 'service' && reference_id.present? }
  before_validation :calculate_total_price

  private

  def set_defaults
    self.item_type ||= 'service'
    self.discount ||= 0
  end

  def set_service_details
    service = ClinicService.find_by(id: reference_id)
    return unless service

    self.description ||= service.name
    self.unit_price ||= service.total_value
  end

  def calculate_total_price
    self.total_price = ((quantity || 0) * (unit_price || 0)) - (discount || 0)
  end
end
