class Client < ApplicationRecord
  belongs_to :user
  has_many :animals, dependent: :destroy
end
