class Show < ApplicationRecord
  belongs_to :schedule
  belongs_to :venue
  belongs_to :artist
end
