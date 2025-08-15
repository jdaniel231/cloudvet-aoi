class Animal < ApplicationRecord
  belongs_to :client

  has_many :appointments, dependent: :destroy
  has_many :weights, dependent: :destroy
  has_many :vaccines, dependent: :destroy

  scope :by_client, ->(client_id) { where(client_id: client_id) if client_id.present? }
end
