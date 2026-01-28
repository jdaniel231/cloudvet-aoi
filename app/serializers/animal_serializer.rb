class AnimalSerializer < ActiveModel::Serializer
  attributes :id, :name, :species, :age, :sex, :client_id
  belongs_to :client
end
