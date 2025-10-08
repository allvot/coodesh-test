# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    sequence(:name) { |n| "Document #{n}" }
    association :vault, factory: :vault
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.txt'), 'application/txt') }
  end
end
