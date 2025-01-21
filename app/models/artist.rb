class Artist < ApplicationRecord
  has_one :show
  validates :name, presence: true
end
