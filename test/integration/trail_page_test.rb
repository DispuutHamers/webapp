require 'application_system_test_case'

class TrailPageTest < ApplicationSystemTestCase
  def setup
    PaperTrail.enabled = true
    PaperTrail.request.enabled = true
    sign_in(users(:one))
  end

  context 'quote' do
    should 'create' do
      q = Quote.create(user: users(:one), text: "Nieuw citaat", reporter: users(:two))
      visit trail_path

      assert has_link? "citeerde Hamer Tester", href: quote_path(q)
      assert_text "Nieuw citaat"
    end

    should 'update' do
      q = Quote.create(user: users(:one), text: "Nieuw citaat", reporter: users(:two))
      q.text = "Gewijzigd citaat"
      q.save!
      visit trail_path

      assert page.has_link? "wijzigde een citaat van Hamer Tester", href: quote_path(q)
      assert_text "Nieuw citaat"
      assert_text "Gewijzigd citaat"
    end

    should 'destroy' do
      quotes(:one).destroy
      visit trail_path

      assert_text "verwijderde citaat van Hamer Tester"
    end

    should 'do all' do
      q = Quote.create(user: users(:one), text: "Nieuw citaat", reporter: users(:two))
      q.reporter = users(:three)
      q.save!
      visit trail_path

      assert page.has_link? "citeerde Hamer Tester", href: quote_path(q)
      assert page.has_link? "wijzigde een citaat van Hamer Tester", href: quote_path(q)
      assert_no_text "verwijderde citaat van Hamer Tester"

      q.destroy
      visit trail_path
      assert page.has_no_link? "citeerde Hamer Tester", href: quote_path(q)
      assert_text "verwijderde citaat van Hamer Tester"
    end
  end

  context 'event' do
    should 'create' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      visit trail_path

      assert page.has_link? "maakte Upcoming event", href: event_path(e), count: 2
    end

    should 'update' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      e.date = '2029-01-01 12:00'
      e.description = "Nieuwe beschrijving"
      e.save!
      visit trail_path

      assert page.has_link? "wijzigde Upcoming event", href: event_path(e), count: 4
    end

    should 'destroy' do
      Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59').destroy
      visit trail_path

      assert_text "verwijderde Upcoming event", count: 2
    end

    should 'do all' do
      e = Event.create!(title: 'Upcoming event', description: "Beschrijving", date: '2030-01-01 20:30', end_time: '2030-01-02 23:59')
      e.user = users(:three)
      e.description = "Nieuwe beschrijving"
      e.save!
      visit trail_path

      assert page.has_link? "maakte Upcoming event", href: event_path(e), count: 2
      assert_text "wijzigde Upcoming event", count: 4
      assert page.has_link? "wijzigde Upcoming event", href: event_path(e)

      e.destroy
      visit trail_path
      assert_text "verwijderde Upcoming event", count: 2
      assert page.has_no_link? "maakte Upcoming event", href: event_path(e)
      assert page.has_no_link? "wijzigde Upcoming event", href: event_path(e)
    end
  end

  context 'signup' do
    should 'inschrijving' do
      users(:three).signup(events(:one), status: true)
      visit trail_path

      signup = users(:three).signups.where(event: events(:one)).first
      assert page.has_link? "schreef zich in voor Dispuutsborrel", href: signup_path(signup)
    end

    should 'uitschrijving' do
      Signup.find_or_create_by(user: users(:three), event: events(:one)).update(status: false, reason: "Kan niet")
      visit trail_path

      signup = users(:three).signups.where(event: events(:one)).first
      assert page.has_link? "schreef zich uit voor Dispuutsborrel", href: signup_path(signup)
    end
  end

  context 'beer' do
    should 'create' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      visit trail_path

      assert page.has_link? "maakte Leffe Blond", href: beer_path(b)
    end

    should 'update' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      b.percentage = "5.0%"
      b.save!
      visit trail_path

      assert page.has_link? "wijzigde Leffe Blond", href: beer_path(b)
    end

    should 'destroy' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      b.destroy
      visit trail_path

      assert_text "verwijderde Leffe Blond"
    end

    should 'do all' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      b.percentage = "5.0%"
      b.save!
      visit trail_path

      assert page.has_link? "maakte Leffe Blond", href: beer_path(b)
      assert page.has_link? "wijzigde Leffe Blond", href: beer_path(b)

      b.destroy
      visit trail_path
      assert_text "verwijderde Leffe Blond"
      assert page.has_no_link? "maakte Leffe Blond", href: beer_path(b)
      assert page.has_no_link? "wijzigde Leffe Blond", href: beer_path(b)
    end
  end

  context 'review' do
    should 'create' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      r = Review.create!(user: users(:one), beer: b, rating: 6, description: "Wel okay.")
      visit trail_path

      assert page.has_link? "reviewde Leffe Blond", href: review_path(r) # Create
      assert page.has_link? "maakte een review van Leffe Blond", href: review_path(r) # Rich text
    end

    should 'update' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      r = Review.create!(user: users(:one), beer: b, rating: 6, description: "Wel okay.")
      r.description = "Toch eigenlijk wel vies."
      r.save!
      visit trail_path

      assert page.has_link? "wijzigde een review van Leffe Blond", href: review_path(r)
    end

    should 'destroy' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      Review.create!(user: users(:one), beer: b, rating: 6, description: "Wel okay.").destroy!
      visit trail_path

      assert_text "verwijderde een review van Leffe Blond"
    end

    should 'do all' do
      b = Beer.create!(name: "Leffe Blond", kind: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
      r = Review.create!(user: users(:one), beer: b, rating: 6, description: "Wel okay.")
      r.description = "Toch eigenlijk wel vies."
      r.save!
      visit trail_path

      assert page.has_link? "reviewde Leffe Blond", href: review_path(r)
      assert page.has_link? "maakte een review van Leffe Blond", href: review_path(r)
      assert page.has_link? "wijzigde een review van Leffe Blond", href: review_path(r), count: 3

      r.destroy!
      visit trail_path
      assert_text "verwijderde een review van Leffe Blond"
      assert page.has_no_link? "reviewde Leffe Blond", href: review_path(r)
      assert page.has_no_link? "een review van Leffe Blond", href: review_path(r)
      assert page.has_no_link? "wijzigde review van Leffe Blond", href: review_path(r), count: 2
    end
  end

  context 'blog' do
    should 'create' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      visit trail_path

      assert page.has_link? "blogte Gaaf nieuws", href: blogitem_path(b) # Update
      assert page.has_link? "maakte Gaaf nieuws", href: blogitem_path(b) # Create rich text
      assert page.has_link? "schreef aan Gaaf nieuws", href: blogitem_path(b) # Create
    end

    should 'update' do
      b = Blogitem.create!(user_id: 3, title: 'Gaaf nieuws', body: "Lorem ipsum")
      b.body = "Nieuwe body"
      b.save!
      visit trail_path

      assert page.has_link? "schreef aan Gaaf nieuws", href: blogitem_path(b)
      assert page.has_link? "wijzigde Gaaf nieuws", href: blogitem_path(b)
    end

    should 'destroy' do
      Blogitem.create!(user_id: 3, title: "Gaaf nieuws", body: "Lorem ipsum").destroy
      visit trail_path

      assert_text "verwijderde Gaaf nieuws"
      assert_text "verwijderde een blogitem"
    end

    should 'do all' do
      b = Blogitem.create!(user_id: 3, title: "Gaaf nieuws", body: "Lorem ipsum")
      b.body = "Nieuwe body"
      b.save!
      visit trail_path

      assert page.has_link? "blogte Gaaf nieuws", href: blogitem_path(b)
      assert page.has_link? "maakte Gaaf nieuws", href: blogitem_path(b)
      assert page.has_link? "schreef aan Gaaf nieuws", href: blogitem_path(b)
      assert page.has_link? "wijzigde Gaaf nieuws", href: blogitem_path(b)

      b.destroy
      visit trail_path

      assert_text "verwijderde Gaaf nieuws"
      assert_text "verwijderde een blogitem"
      assert page.has_no_link? "blogte Gaaf nieuws", href: blogitem_path(b)
      assert page.has_no_link? "maakte beschrijving van", href: blogitem_path(b)
      assert page.has_no_link? "schreef aan Gaaf nieuws", href: blogitem_path(b)
      assert page.has_no_link? "wijzigde beschrijving van een blogitem", href: blogitem_path(b)
    end
  end

  def teardown
    PaperTrail.enabled = false
    PaperTrail.request.enabled = false
  end
end
