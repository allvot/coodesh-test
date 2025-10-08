# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create admin user
require 'factory_bot_rails'

def create_user_environment(role: 'user')
  user = FactoryBot.create(:user, role: role)

  puts "--- #{role.capitalize} user created ---"
  puts "Email: #{user.email}"
  puts "Password: #{user.password}"

  puts 'Creating admin api key'
  read_api_key = FactoryBot.create(:api_key, :read, name: 'Read Key', user: user)
  puts '----------------------------'
  puts 'API Key'
  puts "name: #{read_api_key.name}"
  puts "key: #{read_api_key.key}"

  write_api_key = FactoryBot.create(:api_key, :write, name: 'Write Key', user: user)
  puts '----------------------------'
  puts 'API Key'
  puts "name: #{write_api_key.name}"
  puts "key: #{write_api_key.key}"

  puts '----------------------------'
  puts 'Creating Vaults'

  FactoryBot.create_list(:vault, 3, user: user)
end

%w[user admin].each do |role|
  create_user_environment(role: role)
end
