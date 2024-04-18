class Incident < ApplicationRecord
  belongs_to :ranger

  validates :location, :occurrence_date, :description, presence: true
  validates :public_incident, inclusion: [true, false]
end
