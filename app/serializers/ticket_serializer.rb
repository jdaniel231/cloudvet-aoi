class TicketSerializer < ActiveModel::Serializer
  attributes :id, :payment_status, :subtotal, :discount, :surcharge, :total_amount, :payment_method, :payment_date, :animal_id,
             :client_id, :client_name, :created_at, :updated_at
  belongs_to :user
  belongs_to :animal
  has_many :ticket_items

  def client_id
    object.animal&.client_id
  end

  def client_name
    object.animal&.client&.name
  end
end
