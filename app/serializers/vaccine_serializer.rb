# app/serializers/vaccine_serializer.rb
class VaccineSerializer < ActiveModel::Serializer
  attributes :id, :animal_id, :vaccine_type_id, :application_date, :return_date, :applied_dose, :obs, :user_id

  belongs_to :animal
  belongs_to :vaccine_type
  belongs_to :user
end
