class ClinicServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost_value, :total_value
end
