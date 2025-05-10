# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create_users and API keys with random names
users = {
  'dev@zondersikkel.nl': { id: 1, name: 'Hamers Developer', batch: 0, admin: true },
  'praeses@zondersikkel.nl': { id: 2, name: 'Hamers Praeses', batch: 1 },
  'abactis@zondersikkel.nl': { id: 3, name: 'Hamers Abactis', batch: 2 },
  'questor@zondersikkel.nl': { id: 4, name: 'Hamers Questor', batch: 2 },
  'oudlid@zondersikkel.nl': { id: 5, name: 'Oud-lid 1', batch: 0 },
  'feut1@zondersikkel.nl': { id: 6, name: 'Feut 1', batch: 4 },
  'extern@example.com': { id: 7, name: 'External user' },
  'lid@zondersikkel.nl': { id: 8, name: 'Algemeen lid', batch: 3 }
}

users.each do |email, options|
  u = User.create!(email: email, password: '12345678', password_confirmation: '12345678', **options)
  ApiKey.create!(user: u, name: 'Key 1')
  ApiKey.create!(user: u, name: 'Key 2')
end

# Create groups
Usergroup.create!(id: 2, name: 'Triumviraat', description: 'Het triumviraat bestuurt onze vereniging en bestaat uit een praeses, ab actis en quaestor')
Usergroup.create!(id: 4, name: 'Lid', description: 'In deze groep zitten alle actieve leden van de vereniging, zodat ze de juisten rechten hebben.').logo.attach(io: File.open('test/fixtures/active_storage/user_groups/hamers.png'), filename: 'hamers.png', content_type: 'image/png')
Usergroup.create!(id: 12, name: 'O-lid', description: 'In deze groep zitten alle oud-leden van de vereniging, zodat wij ze altijd kunnen herinneren.').logo.attach(io: File.open('test/fixtures/active_storage/user_groups/oudjes.png'), filename: 'oudjes.png', content_type: 'image/png')
Usergroup.create!(id: 5, name: 'A-lid', description: 'In deze groep zitten alle aspirant leden van de vereniging, zodat ze de juisten rechten hebben.').logo.attach(io: File.open('test/fixtures/active_storage/user_groups/aspiranten.png'), filename: 'aspiranten.png', content_type: 'image/png')
Usergroup.create!(id: 11, name: 'Developer', description: 'Onze developers onderhouden deze website.').logo.attach(io: File.open('test/fixtures/active_storage/user_groups/developers.png'), filename: 'developers.png', content_type: 'image/png')
Usergroup.create!(id: 17, name: 'H4x0rz', description: 'In deze groep zitten leden die een CTF eens in de zoveel tijd leuk vinden.').logo.attach(io: File.open('test/fixtures/active_storage/user_groups/hackers.png'), filename: 'hackers.png', content_type: 'image/png')
Usergroup.create!(name: 'Pokerbazen').logo.attach(io: File.open('test/fixtures/active_storage/user_groups/poker.png'), filename: 'poker.png', content_type: 'image/png')
Usergroup.create!(id: 21, name: 'Trajectcoördinatoren')
Usergroup.create!(id: 22, name: 'Archived group', archived: true, description: 'Deze groep is gearchiveerd.')

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
Group.create!(user_id: 1, group_id: Usergroup.find_by_name('Developer').id)
Group.create!(user_id: 5, group_id: Usergroup.find_by_name('O-lid').id)
Group.create!(user_id: 6, group_id: Usergroup.find_by_name('A-lid').id)

# Create quotes
Quote.create!(user_id: 1, text: 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar', reporter_id: 2)
Quote.create!(user_id: 2, text: 'Het mag ook een hele mooie, goed schoongemaakte penis zijn..', reporter_id: 3)
Quote.create!(user_id: 3, text: 'Ik hou wel van enorme lullen', reporter_id: 1)
Quote.create!(user_id: nil, text: 'Dit is een anonieme quote', reporter_id: nil)

# Create beers
Beer.create!(name: 'Leffe Blond', kind: 'Blond', brewer: 'Leffe', country: 'België', percentage: '6.6 %')
Beer.create!(name: 'Abt 12', kind: 'Abbey Ale', brewer: 'St. Bernardus', country: 'Nederland', percentage: '10 %')

# Create reviews
Review.create!(user_id: 1, beer_id: 1, rating: 6, description: 'Wel okay.')
Review.create!(user_id: 2, beer_id: 1, rating: 8, description: 'Goed bier.')
Review.create!(user_id: 3, beer_id: 1, rating: 5, description: 'Meh..')
Review.create!(user_id: 3, beer_id: 2, rating: 1, description: 'Wat voor bocht is dit?')
Review.create!(user_id: 5, beer_id: 2, rating: 9, description: 'Beste bier ooit!')
Review.create!(user_id: 6, beer_id: 2, rating: 3, description: 'Matig..')

# Update average rating
Beer.all.each(&:update_cijfer)

# Create events
Event.create!(title: 'Past event', date: '2020-01-01 20:30', end_time: '2020-01-02 23:59',
              deadline: '2030-01-01 20:00', user_id: 5)
Event.create!(title: 'Upcoming event', date: '2030-01-01 20:30', end_time: '2030-01-02 23:59',
              deadline: '2030-01-01 20:00', user_id: 1)
Event.create!(title: 'Public event', date: '2022-01-01 20:00', end_time: '2022-01-01 23:00',
              deadline: '2030-01-01 12:00', invitation_code: SecureRandom.uuid)

# Create signups
Signup.create!(event_id: 1, user_id: 1)
Signup.create!(event_id: 1, user_id: 2)
Signup.create!(event_id: 1, user_id: 3)
Signup.create!(event_id: 1, user_id: 4)
Signup.create!(event_id: 1, user_id: 5)
Signup.create!(event_id: 2, user_id: 1)
Signup.create!(event_id: 2, user_id: 2, status: false, reason: 'Fuck feuten')
Signup.create!(event_id: 2, user_id: 3, status: false, reason: 'Geen zin')
Signup.create!(event_id: 2, user_id: 6)
Signup.create!(event_id: 3, user_id: 1)
Signup.create!(event_id: 3, user_id: 2)
Signup.create!(event_id: 3, user_id: 3)
Signup.create!(event_id: 3, user_id: 4)
ExternalSignup.create!(event_id: 3, first_name: 'Bob', last_name: 'de Bouwer', email: 'bob@debouwer.nl',
                       note: 'Nice dat ik mee mag!')

# Create blogposts
Blogitem.create!(user_id: 1, title: 'Test publieke blogpost', body: 'Lorem ipsum', public: true)
Blogitem.create!(user_id: 3, title: 'Test gewone blogpost', body: 'Lorem ipsum')

# Create news items
News.create!(title: 'Test-nieuwsbericht', body: 'Lorem ipsum.')
News.create!(title: 'Nog een testbericht', body: 'A different kind of lorem ipsum.')

# Create meeting
Meeting.create!(onderwerp: 'ALV VI', date: Date.today, agenda: "1. Opening\n2.Vaststellen agenda", chairman_id: 2,
                secretary_id: 3, user_ids: User.leden_en_aspiranten.map(&:id))

# Create stickers
Sticker.create!(user_id: 1, lat: 52.252731, lon: 6.8610066, notes: 'Witbreuksweg 393-C')
Sticker.create!(user_id: 1, lat: 51.9641653, lon: 7.6234247, notes: 'Munster')

# Create chugtypes with chugs
Chugtype.create!(id: 1, name: 'Grolsch Glas', amount: 250)
Chugtype.create!(id: 2, name: 'Smirnoff Ice', amount: 700)

Chug.create!(user_id: 1, chugtype_id: 1, reporter_id: 2, time: 3.232)
Chug.create!(user_id: 2, chugtype_id: 1, reporter_id: 1, time: 4.3434)
Chug.create!(user_id: 3, chugtype_id: 1, reporter_id: 2, time: 5.45454)
Chug.create!(user_id: 4, chugtype_id: 1, reporter_id: 1, time: 6.99, comment:'Net snel genoeg.')
Chug.create!(user_id: 1, chugtype_id: 2, reporter_id: 2, time: 6.77)
