class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :cpf, :rg, :address, :number_address, :compl_address, :neighborhoods, :phone
  has_many :animals, serializer: AnimalSerializer
end