# frozen_string_literal: true

FactoryBot.define do
  factory :api_key do
    sequence(:name) { |n| "key_#{n}" }
    association :user

    trait :read do
      permission_level { 'read' }
    end

    trait :write do
      permission_level { 'write' }
    end
  end
end
