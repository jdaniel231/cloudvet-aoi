class Animal < ApplicationRecord
  belongs_to :client

  has_many :appointments, dependent: :destroy
  has_many :weights, dependent: :destroy
end
