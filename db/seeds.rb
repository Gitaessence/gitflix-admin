# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', user_type_id: 2) if Rails.env.development?

if Rails.env.production?
  UserType.create!(user_type: 0)
  UserType.create!(user_type: 1)
  UserType.create!(user_type: 2)
end