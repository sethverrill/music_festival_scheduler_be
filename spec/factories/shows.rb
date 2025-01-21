FactoryBot.define do
  factory :show do
    time_slot { rand(1..8) }
    schedule { nil }
    venue { association :venue }
    artist { association :artist }
  end
end
