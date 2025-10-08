# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    role { 'user' }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'Password123' }

    trait :admin do
      role { 'admin' }
    end
  end
end
