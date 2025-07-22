class Client < ApplicationRecord
  validates :cpf, uniqueness: true

  belongs_to :user
  has_many :animals, dependent: :destroy
end
