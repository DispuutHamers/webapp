require 'application_system_test_case'

class TrailPageTest < ApplicationSystemTestCase
  def setup
    sign_in(users(:one))
  end

  context 'quote' do
    should 'create' do
      q = Quote.create(user: users(:one), text: "Nieuwe quote", reporter: users(:two))
      visit trail_path

      assert has_link? "citeerde Hamer Tester", href: quote_path(q)
    end

    should 'update' do
      q = quotes(:one)
      q.reporter = users(:three)
      q.save!
      visit trail_path

      assert page.has_link? "wijzigde een citaat van Hamer Tester", href: quote_path(q)
    end

    should 'destroy' do
      quotes(:one).destroy
      visit trail_path

      assert_text "verwijderde quote"
    end

    should 'do all' do
      q = Quote.create(user: users(:one), text: "Nieuwe quote", reporter: users(:two))
      q.reporter = users(:three)
      q.save!
      q.destroy
      visit trail_path

      assert page.has_link? "citeerde Hamer Tester", href: root_path
      assert page.has_link? "wijzigde een citaat van Hamer Tester", href: root_path
      assert_text "verwijderde quote"
    end
  end

  context 'event' do
    should 'create' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      visit trail_path

      assert page.has_link? "maakte activiteit 'Upcoming event'", href: event_path(e)
      assert page.has_link? "maakte opgemaakte tekst", href: event_path(e)
    end

    should 'update' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      e.date = '2029-01-01 12:00'
      e.description = "Nieuwe beschrijving"
      e.save!
      visit trail_path

      assert page.has_link? "wijzigde activiteit 'Upcoming event'", href: event_path(e)
      assert page.has_link? "wijzigde opgemaakte tekst", href: event_path(e)
    end

    should 'destroy' do
      Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59').destroy
      visit trail_path

      assert_text "verwijderde activiteit"
      assert_text "verwijderde opgemaakte tekst"
    end

    should 'do all' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      e.user = users(:three)
      e.description = "Nieuwe beschrijving"
      e.save!
      visit trail_path

      assert page.has_link? "maakte activiteit 'Upcoming event'", href: event_path(e)
      assert page.has_link? "maakte opgemaakte tekst", href: event_path(e)
      assert page.has_link? "wijzigde activiteit 'Upcoming event'", href: event_path(e)
      assert page.has_link? "wijzigde opgemaakte tekst", href: event_path(e)

      e.destroy
      visit trail_path
      assert_text "verwijderde activiteit"
      assert_text "verwijderde opgemaakte tekst"
      assert page.has_no_link? "maakte activiteit 'Upcoming event'", href: event_path(e)
      assert page.has_no_link? "maakte opgemaakte tekst", href: event_path(e)
      assert page.has_no_link? "wijzigde activiteit 'Upcoming event'", href: event_path(e)
      assert page.has_no_link? "wijzigde opgemaakte tekst", href: event_path(e)
    end
  end

  context 'signup' do
    should 'inschrijving' do
      users(:three).signup(events(:one), status: true)
      visit trail_path

      signup = users(:three).signups.where(event: events(:one)).first
      assert page.has_link? "schreef zich in voor 'Dispuutsborrel'", href: signup_path(signup)
    end

    should 'uitschrijving' do
      Signup.find_or_create_by(user: users(:three), event: events(:one)).update(status: false, reason: "Kan niet")
      visit trail_path

      signup = users(:three).signups.where(event: events(:one)).first
      assert page.has_link? "schreef zich uit voor 'Dispuutsborrel'", href: signup_path(signup)
    end
  end

  context 'beer' do
    should 'create' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      visit trail_path

      assert page.has_link? "maakte bier 'Leffe Blond'", href: beer_path(b)
    end

    should 'update' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      b.percentage = "5.0%"
      b.save!
      visit trail_path

      assert page.has_link? "wijzigde bier 'Leffe Blond'", href: beer_path(b)
    end

    should 'destroy' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      b.destroy
      visit trail_path

      assert_text "verwijderde bier"
    end

    should 'do all' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      b.percentage = "5.0%"
      b.save!
      visit trail_path

      assert page.has_link? "maakte bier 'Leffe Blond'", href: beer_path(b)
      assert page.has_link? "wijzigde bier 'Leffe Blond'", href: beer_path(b)

      b.destroy
      visit trail_path
      assert_text "verwijderde bier"
      assert page.has_no_link? "maakte bier 'Leffe Blond'", href: beer_path(b)
      assert page.has_no_link? "wijzigde bier 'Leffe Blond'", href: beer_path(b)
    end
  end

  context 'blog' do
    should 'create' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      visit trail_path

      assert page.has_link? "blogte 'Gaaf nieuws'", href: blogitem_path(b)
      assert page.has_link? "maakte opgemaakte tekst", href: blogitem_path(b)
    end

    should 'update' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      b.body = "Nieuwe body"
      b.save!
      visit trail_path

      assert page.has_link? "schreef aan 'Gaaf nieuws'", href: blogitem_path(b)
      assert page.has_link? "wijzigde opgemaakte tekst", href: blogitem_path(b)
    end

    should 'destroy' do
      Blogitem.create!(user_id: 3, title: "Gaaf nieuws", body: "Lorem ipsum").destroy
      visit trail_path

      assert_text "verwijderde blog"
      assert_text "verwijderde opgemaakte tekst"
    end

    should 'do all' do
      b = Blogitem.create!(user_id: 3, title: "Gaaf nieuws", body: "Lorem ipsum")
      b.body = "Nieuwe body"
      b.save!
      visit trail_path

      assert page.has_link? "blogte 'Gaaf nieuws'", href: blogitem_path(b)
      assert page.has_link? "maakte opgemaakte tekst", href: blogitem_path(b)
      assert page.has_link? "schreef aan 'Gaaf nieuws'", href: blogitem_path(b)
      assert page.has_link? "wijzigde opgemaakte tekst", href: blogitem_path(b)

      b.destroy
      visit trail_path

      assert_text "verwijderde blog"
      assert_text "verwijderde opgemaakte tekst"
      assert page.has_no_link? "blogte 'Gaaf nieuws'", href: blogitem_path(b)
      assert page.has_no_link? "maakte opgemaakte tekst", href: blogitem_path(b)
      assert page.has_no_link? "schreef aan 'Gaaf nieuws'", href: blogitem_path(b)
      assert page.has_no_link? "wijzigde opgemaakte tekst", href: blogitem_path(b)
    end
  end

  def teardown
    take_screenshot
  end
end
