class User < ApplicationRecord
  has_one :schedule
  validates :first_name, :last_name, :email, presence: true
end
