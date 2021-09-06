# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# create_users
User.create!(email: "dev@zondersikkel.nl", password: "12345678", password_confirmation: "12345678", name: "Hamers Developer")
User.create!(email: "praeses@zondersikkel.nl", password: "12345678", password_confirmation: "12345678", name: "Hamers Praeses")
User.create!(email: "abactis@zondersikkel.nl", password: "12345678", password_confirmation: "12345678", name: "Hamers Abactis")
User.create!(email: "questor@zondersikkel.nl", password: "12345678", password_confirmation: "12345678", name: "Hamers Questor")
User.create!(email: "oudlid@zondersikkel.nl", password: "12345678", password_confirmation: "12345678", name: "Oud-lid 1")
User.create!(email: "feut1@zondersikkel.nl", password: "12345678", password_confirmation: "12345678", name: "Feut 1")

# Create groups
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

# Make users lid
User.all.each do |user|
  next if [5, 6].include?(user.id)
  Group.create!(user_id: user.id, group_id: 4)
end

# Fill Triumviraat
Group.create!(user_id: 2, group_id: 1)
Group.create!(user_id: 3, group_id: 1)
Group.create!(user_id: 4, group_id: 1)

# Fill the rest of the groups
Group.create!(user_id: 1, group_id: 11)
Group.create!(user_id: 5, group_id: 12)
Group.create!(user_id: 6, group_id: 5)

# Create quotes
Quote.create!(user_id: 1, text: "Turken doen aan eerwraak enzo. Negers swaffelen alleen maar", reporter: 2)
Quote.create!(user_id: 2, text: "Het mag ook een hele mooie, goed schoongemaakte penis zijn..", reporter: 3)
Quote.create!(user_id: 3, text: "Ik hou wel van enorme lullen", reporter: 1)

# Create events
Event.create(title: 'Past event', date: '2020-01-01 20:30', end_time: '2020-01-02 23:59', deadline: '2030-01-01 20:00', user_id: 5)
Event.create(title: 'Upcoming event', date: '2030-01-01 20:30', end_time: '2030-01-02 23:59', deadline: '2030-01-01 20:00', user_id: 1)

# Create signups
Signup.create(event_id: 1, user_id: 1)
Signup.create(event_id: 1, user_id: 2)
Signup.create(event_id: 1, user_id: 3)
Signup.create(event_id: 1, user_id: 4)
Signup.create(event_id: 1, user_id: 5)
Signup.create(event_id: 2, user_id: 1)
Signup.create(event_id: 2, user_id: 2, status: false, reason: "Fuck feuten")
Signup.create(event_id: 2, user_id: 3, status: false, reason: "Geen zin")
Signup.create(event_id: 2, user_id: 6)
