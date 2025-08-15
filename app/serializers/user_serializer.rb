class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :crmv

  # has_many :clients, serializer: ClientSerializer
end