require 'application_system_test_case'

class TrailPageTest < ApplicationSystemTestCase
  def setup
    PaperTrail.enabled = true
    sign_in(users(:one))
  end

  context 'quote' do
    should 'create' do
      Quote.create(user: users(:one), text: "Nieuwe quote", reporter: users(:two))
      visit trail_path

      has_link? "citeerde Hammer Tester", href: root_path
    end

    should 'update' do
      q = quotes(:one)
      q.reporter = users(:three)
      q.save!
      visit trail_path

      has_link? "wijzigde een citaat van Hamer Tester", href: root_path
    end

    should 'destroy' do
      quotes(:one).destroy
      visit trail_path

      has_link? "verwijderde quote", href: root_path
    end

    should 'do all' do
      q = Quote.create(user: users(:one), text: "Nieuwe quote", reporter: users(:two))
      q.reporter = users(:three)
      q.save!
      q.destroy
      visit trail_path

      has_link? "citeerde Hamer Tester", href: root_path
      has_link? "wijzigde een citaat van Hamer Tester", href: root_path
      has_link? "verwijderde quote", href: root_path
    end
  end

  context 'event' do
    should 'create' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      visit trail_path

      has_link? "maakte activiteit", href: e
      has_link? "maakte opgemaakte tekst", href: e
    end

    should 'update' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      e.date = '2029-01-01 12:00'
      e.description = "Nieuwe beschrijving"
      e.save!
      visit trail_path

      has_link? "wijzigde activiteit", href: e
      has_link? "wijzigde opgemaakte tekst", href: e
    end

    should 'destroy' do
      Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59').destroy
      visit trail_path

      assert_selector "span", text: "verwijderde activiteit"
      assert_selector "span", text: "verwijderde opgemaakte tekst"
    end

    should 'do all' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      e.user = users(:three)
      e.description = "Nieuwe beschrijving"
      e.save!
      e.destroy
      visit trail_path

      has_link? "maakte activiteit upcoming event", href: e
      has_link? "maakte opgemaakte tekst", href: e
      has_link? "wijzigde activiteit upcoming event", href: e
      has_link? "wijzigde opgemaakte tekst", href: e
      assert_selector "span", text: "verwijderde activiteit"
      assert_selector "span", text: "verwijderde opgemaakte tekst"
    end
  end

  context 'signup' do
    should 'inschrijving' do
      users(:three).signup(events(:one), status: true)
      visit trail_path

      signup = users(:three).signups.where(event: events(:one)).first
      has_link? "schreef zich in voor Dispuutsborrel", href: signup
    end

    should 'uitschrijving' do
      Signup.find_or_create_by(user: users(:three), event: events(:one)).update(status: false, reason: "Kan niet")
      visit trail_path

      signup = users(:three).signups.where(event: events(:one)).first
      has_link? "schreef zich uit voor Dispuutsborrel", href: signup
    end
  end

  context 'blog' do
    should 'create' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      visit trail_path

      has_link? "blogte Gaaf nieuws", href: b
      has_link? "maakte opgemaakte tekst", href: b
    end

    should 'update' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      b.body = "Nieuwe body"
      b.save!
      visit trail_path

      has_link? "schreef aan Gaaf nieuws", href: b
      has_link? "wijzigde opgemaakte tekst", href: b
    end

    should 'destroy' do
      Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum").destroy
      visit trail_path

      assert_selector "span", text: "verwijderde blog"
      assert_selector "span", text: "verwijderde opgemaakte tekst"
    end

    should 'do all' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      b.body = "Nieuwe body"
      b.save!
      b.destroy
      visit trail_path

      has_link? "blogte Gaaf nieuws", href: b
      has_link? "maakte opgemaakte tekst", href: b
      has_link? "schreef aan Gaaf nieuws", href: b
      has_link? "wijzigde opgemaakte tekst", href: b
      assert_selector "span", text: "verwijderde blog"
      assert_selector "span", text: "verwijderde opgemaakte tekst"
    end
  end

  def teardown
    # take_screenshot
    PaperTrail.enabled = false
  end
end
