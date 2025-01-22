FactoryBot.define do
  factory :schedule do
    user { association :user }
  end
end
