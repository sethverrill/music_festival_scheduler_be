FactoryBot.define do
  factory :show do
    time_slot { rand(1..8) }
    venue
    artist
  end
end
