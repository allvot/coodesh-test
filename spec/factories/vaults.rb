# frozen_string_literal: true

FactoryBot.define do
  factory :vault do
    association :user, factory: :user
    sequence(:name) { |n| "Vault #{n}" }
  end
end
