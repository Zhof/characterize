  # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of thle Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Character.destroy_all
User.destroy_all

user1 = User.create!(username: "dndboi", first_name: "rick", last_name: "moranis", email: "email@email.com", password: "1guest")
char1 = Character.create!(full: false, name: "rick", race: "human", job: "scientist", location: "unknown", trait: "smart", quirk: "drunk", user: user1)
