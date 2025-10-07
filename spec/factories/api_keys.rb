FactoryBot.define do
  factory :api_key do
    key { "MyText" }
    name { "MyString" }
    user { nil }
  end
end
