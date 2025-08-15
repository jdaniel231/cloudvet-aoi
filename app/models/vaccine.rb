class Vaccine < ApplicationRecord
  belongs_to :animal
  belongs_to :vaccine_type
  belongs_to :user
end
