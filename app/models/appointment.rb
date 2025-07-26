class Appointment < ApplicationRecord
  belongs_to :animal
  belongs_to :client
  belongs_to :user
end
