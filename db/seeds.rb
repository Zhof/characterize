  # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of thle Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Character.destroy_all
User.destroy_all

user1 = User.create!(username: "Dndrulez", first_name: "ricky", last_name: "moranis", email: "email@email.com", password: "1guest")
user2 = User.create!(email: "email2@email.com", password: "2guest", username: "iliekdnd", first_name: "segourney", last_name: "reaver")
