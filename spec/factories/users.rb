FactoryBot.define do
  factory :user do
    role { "user" }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "Password123" }
  end
end
