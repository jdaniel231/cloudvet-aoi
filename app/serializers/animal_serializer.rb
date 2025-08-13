class AnimalSerializer < ActiveModel::Serializer
  attributes :id, :name, :species, :age, :sex
  belongs_to :client
end