FactoryBot.define do
  factory :api_key do
    sequence(:name) { |n| "key_#{n}" }
    association :user
  end
end
