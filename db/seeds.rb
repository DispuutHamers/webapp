# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create_users and API keys with random names
users = {
  'dev@zondersikkel.nl': { id: 1, name: "Hamers Developer", batch: 0, admin: true },
  'praeses@zondersikkel.nl': { id: 2, name: "Hamers Praeses", batch: 1 },
  'abactis@zondersikkel.nl': { id: 3, name: "Hamers Abactis", batch: 2 },
  'questor@zondersikkel.nl': { id: 4, name: "Hamers Questor", batch: 3 },
  'oudlid@zondersikkel.nl': { id: 5, name: "Oud-lid 1", batch: 0 },
  'feut1@zondersikkel.nl': { id: 6, name: "Feut 1", batch: 4 },
  'extern@example.com': { id: 7, name: "External user" }
}

users.each do |email, options|
  u = User.create!(email: email, password: "12345678", password_confirmation: "12345678", **options)
  ApiKey.create!(user: u, name: "Key 1")
  ApiKey.create!(user: u, name: "Key 2")
end

# Create groups
Usergroup.create!(id: 2, name: "Triumviraat")
Usergroup.create!(id: 4, name: "Lid").logo.attach(io: File.open('test/fixtures/active_storage/user_groups/hamers.png'), filename: 'hamers.png', content_type: 'image/png')
Usergroup.create!(id: 12, name: "O-Lid").logo.attach(io: File.open('test/fixtures/active_storage/user_groups/oudjes.png'), filename: 'oudjes.png', content_type: 'image/png')
Usergroup.create!(id: 5, name: "A-Lid").logo.attach(io: File.open('test/fixtures/active_storage/user_groups/aspiranten.png'), filename: 'aspiranten.png', content_type: 'image/png')
Usergroup.create!(id: 11, name: "Developer").logo.attach(io: File.open('test/fixtures/active_storage/user_groups/developers.png'), filename: 'developers.png', content_type: 'image/png')
Usergroup.create!(id: 17, name: "H4x0rz").logo.attach(io: File.open('test/fixtures/active_storage/user_groups/hackers.png'), filename: 'hackers.png', content_type: 'image/png')
Usergroup.create!(name: "Pokerbazen").logo.attach(io: File.open('test/fixtures/active_storage/user_groups/poker.png'), filename: 'poker.png', content_type: 'image/png')
Usergroup.create!(id: 21, name: "Trajectcoördinatoren")

# Make users lid
User.all.each do |user|
  next if [6, 7].include?(user.id)
  Group.create!(user: user, group_id: 4)
end

# Fill Triumviraat
Group.create!(user_id: 2, group_id: 2)
Group.create!(user_id: 3, group_id: 2)
Group.create!(user_id: 4, group_id: 2)

# Set deleted_at for group objects so that o-lid are not lid anymore
Group.find_by(user_id: 5, group_id: 4).destroy

# Fill the rest of the groups
Group.create!(user_id: 1, group_id: Usergroup.find_by_name("Developer").id)
Group.create!(user_id: 5, group_id: Usergroup.find_by_name("O-lid").id)
Group.create!(user_id: 6, group_id: Usergroup.find_by_name("A-lid").id)

# Create quotes
Quote.create!(user_id: 1, text: "Turken doen aan eerwraak enzo. Negers swaffelen alleen maar", reporter_id: 2)
Quote.create!(user_id: 2, text: "Het mag ook een hele mooie, goed schoongemaakte penis zijn..", reporter_id: 3)
Quote.create!(user_id: 3, text: "Ik hou wel van enorme lullen", reporter_id: 1)

# Create beers
Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
Beer.create!(name: "Abt 12", kind: "Abbey Ale", brewer: "St. Bernardus", country: "Nederland", percentage: "10 %")

# Create reviews
Review.create!(user_id: 1, beer_id: 1, rating: 6, description: "Wel okay.")
Review.create!(user_id: 2, beer_id: 1, rating: 8, description: "Goed bier.")
Review.create!(user_id: 3, beer_id: 1, rating: 5, description: "Meh..")
Review.create!(user_id: 3, beer_id: 2, rating: 1, description: "Wat voor bocht is dit?")
Review.create!(user_id: 5, beer_id: 2, rating: 9, description: "Beste bier ooit!")
Review.create!(user_id: 6, beer_id: 2, rating: 3, description: "Matig..")

# Create events
Event.create!(title: 'Past event', date: '2020-01-01 20:30', end_time: '2020-01-02 23:59', deadline: '2030-01-01 20:00', user_id: 5)
Event.create!(title: 'Upcoming event', date: '2030-01-01 20:30', end_time: '2030-01-02 23:59', deadline: '2030-01-01 20:00', user_id: 1)
Event.create!(title: 'Public event', date: '2022-01-01 20:00', end_time: '2022-01-01 23:00', deadline: '2021-12-31 12:00', invitation_code: SecureRandom.uuid)

# Create signups
Signup.create!(event_id: 1, user_id: 1)
Signup.create!(event_id: 1, user_id: 2)
Signup.create!(event_id: 1, user_id: 3)
Signup.create!(event_id: 1, user_id: 4)
Signup.create!(event_id: 1, user_id: 5)
Signup.create!(event_id: 2, user_id: 1)
Signup.create!(event_id: 2, user_id: 2, status: false, reason: "Fuck feuten")
Signup.create!(event_id: 2, user_id: 3, status: false, reason: "Geen zin")
Signup.create!(event_id: 2, user_id: 6)
Signup.create!(event_id: 3, user_id: 1)
Signup.create!(event_id: 3, user_id: 2)
Signup.create!(event_id: 3, user_id: 3)
Signup.create!(event_id: 3, user_id: 4)
ExternalSignup.create!(event_id: 3, first_name: "Bob", last_name: "de Bouwer", email: "bob@debouwer.nl", note: "Nice dat ik mee mag!")

# Create blogposts
Blogitem.create!(user_id: 1, title: 'Test publieke blogpost', body: "Lorem ipsum", public: true)
Blogitem.create!(user_id: 3, title: 'Test gewone blogpost', body: "Lorem ipsum")

# Create news items
News.create!(title: "Test-nieuwsbericht", body: "Lorem ipsum.")
News.create!(title: "Nog een testbericht", body: "A different kind of lorem ipsum.")

# Create meeting
Meeting.create!(onderwerp: "ALV VI", date: Date.today, agenda: "1. Opening\n2.Vaststellen agenda", chairman_id: 2, secretary_id: 3, user_ids: User.leden_en_aspiranten.map(&:id))
