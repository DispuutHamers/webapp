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

      assert_selector "span", text: "citeerde Hamer Tester"
    end

    should 'update' do
      q = quotes(:one)
      q.reporter = users(:three)
      q.save!
      visit trail_path

      assert_selector "span", text: "wijzigde een citaat van Hamer Tester"
    end

    should 'destroy' do
      quotes(:one).destroy
      visit trail_path

      assert_selector "span", text: "verwijderde quote"
    end

    should 'do all' do
      q = Quote.create(user: users(:one), text: "Nieuwe quote", reporter: users(:two))
      q.reporter = users(:three)
      q.save!
      q.destroy
      visit trail_path

      assert_selector "span", text: "citeerde Hamer Tester"
      assert_selector "span", text: "wijzigde een citaat van Hamer Tester"
      assert_selector "span", text: "verwijderde quote"
    end
  end

  context 'event' do
    should 'create' do
      Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      visit trail_path

      assert_selector "span", text: "maakte activiteit"
      assert_selector "span", text: "maakte opgemaakte tekst"
    end

    should 'update' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      e.date = '2029-01-01 12:00'
      e.description = "Nieuwe beschrijving"
      e.save!
      visit trail_path

      assert_selector "span", text: "wijzigde activiteit"
      assert_selector "span", text: "wijzigde opgemaakte tekst"
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

      assert_selector "span", text: "maakte activiteit"
      assert_selector "span", text: "maakte opgemaakte tekst"
      assert_selector "span", text: "wijzigde activiteit"
      assert_selector "span", text: "wijzigde opgemaakte tekst"
      assert_selector "span", text: "verwijderde activiteit"
    end
  end

  context 'signup' do
    should 'inschrijving' do
      users(:three).signup(events(:one), status: true)
      visit trail_path

      assert_selector "span", text: "schreef zich in voor Dispuutsborrel"
    end

    should 'uitschrijving' do
      Signup.find_or_create_by(user: users(:three), event: events(:one)).update(status: false, reason: "Kan niet")
      visit trail_path

      assert_selector "span", text: "schreef zich uit voor Dispuutsborrel"
    end
  end

  context 'blog' do
    should 'create' do
      Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      visit trail_path

      assert_selector "span", text: "blogte Gaaf nieuws"
      assert_selector "span", text: "maakte opgemaakte tekst"
    end

    should 'update' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      b.body = "Nieuwe body"
      b.save!
      visit trail_path

      assert_selector "span", text: "schreef aan Gaaf nieuws"
      assert_selector "span", text: "wijzigde opgemaakte tekst"
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

      assert_selector "span", text: "blogte Gaaf nieuws"
      assert_selector "span", text: "maakte opgemaakte tekst"
      assert_selector "span", text: "schreef aan Gaaf nieuws"
      assert_selector "span", text: "wijzigde opgemaakte tekst"
      assert_selector "span", text: "verwijderde blog"
      assert_selector "span", text: "verwijderde opgemaakte tekst"
    end
  end

  def teardown
    take_screenshot
    PaperTrail.enabled = false
  end
end
