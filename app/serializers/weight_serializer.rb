class WeightSerializer < ActiveModel::Serializer
  attributes :id, :kg, :created_at, :updated_at
  belongs_to :animal, serializer: AnimalSerializer
  belongs_to :user
end