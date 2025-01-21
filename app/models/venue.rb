class Venue < ApplicationRecord
  has_many :shows
  validates :name, presence: true
end
