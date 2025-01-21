class Show < ApplicationRecord
  belongs_to :schedule, optional: true
  belongs_to :venue
  belongs_to :artist

  validates :time_slot, presence: true
end
