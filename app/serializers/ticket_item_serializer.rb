class TicketItemSerializer < ActiveModel::Serializer
  attributes :id, :item_type, :description, :quantity, :unit_price, :discount, :total_price, :created_at, :updated_at
  belongs_to :ticket
end
