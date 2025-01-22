class Show < ApplicationRecord
  has_many :schedule_shows, dependent: :destroy
  has_many :schedules, through: :schedule_shows
  belongs_to :venue
  belongs_to :artist
  validates :time_slot, presence: true
end
