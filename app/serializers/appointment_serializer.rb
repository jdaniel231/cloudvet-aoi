class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :chief_complaint, :medical_history, :suspected_exams, :created_at, :updated_at
  belongs_to :animal, serializer: AnimalSerializer
  belongs_to :client, serializer: ClientSerializer
  belongs_to :user
end