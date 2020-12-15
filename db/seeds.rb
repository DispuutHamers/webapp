# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "dev@zondersikkel.nl", password: "12345678", password_confirmation: "12345678", name: "Hamers Developer")
Usergroup.create!(name: "Triumviraat")
Usergroup.create!(name: "2")
Usergroup.create!(name: "3")
Usergroup.create!(name: "Lid")
Usergroup.create!(name: "A-Lid")
Usergroup.create!(name: "Secretaris-Generaal")
Usergroup.create!(name: "7")
Usergroup.create!(name: "8")
Usergroup.create!(name: "9")
Usergroup.create!(name: "10")
Usergroup.create!(name: "Developer")
Usergroup.create!(name: "O-Lid")
Group.create!(user_id: 1, group_id: 11)
Group.create!(user_id: 1, group_id: 4)
Group.create!(user_id: 1, group_id: 1)
Quote.create!(user_id: 1, text: "Welkom in de hamers dev omgeving!", reporter: 1)
