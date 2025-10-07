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

admin_user = FactoryBot.create(:user, email: "admin@example.com", role: "admin")

puts "Admin user created"
puts "Email: #{admin_user.email}"
puts "Password: #{admin_user.password}"