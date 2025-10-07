FactoryBot.define do
  factory :document do
    sequence(:name) { |n| "Document #{n}" }
    association :vault, factory: :vault
  end
end
