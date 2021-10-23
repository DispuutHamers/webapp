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

      assert_selector "p", text: "citeerde Hamer Tester"
    end

    should 'update' do
      q = quotes(:one)
      q.reporter = users(:three)
      q.save!
      visit trail_path

      assert_selector "p", text: "wijzigde een citaat van Hamer Tester"
    end

    should 'destroy' do
      quotes(:one).destroy
      visit trail_path

      assert_selector "p", text: "verwijderde quote"
    end

    should 'do all at once' do
      q = Quote.create(user: users(:one), text: "Nieuwe quote", reporter: users(:two))
      q.reporter = users(:three)
      q.save!
      q.destroy
      visit trail_path

      assert_selector "p", text: "citeerde Hamer Tester"
      assert_selector "p", text: "wijzigde een citaat van Hamer Tester"
      assert_selector "p", text: "verwijderde quote"
    end
  end

  context 'event' do
    should 'create' do
      Event.create!(title: 'Upcoming event', date: '2030-01-01 20:30', end_time: '2030-01-02 23:59', deadline: '2030-01-01 20:00', user_id: 1)
      visit trail_path

      assert_selector "p", text: "maakte activiteit"
    end

    should 'update' do
      e = events(:one)
      e.date = '2029-01-01 12:00'
      e.save!
      visit trail_path

      assert_selector "p", text: "wijzigde activiteit"
    end

    should 'destroy' do
      events(:one).destroy
      visit trail_path

      assert_selector "p", text: "verwijderde activiteit"
    end
  end

  def teardown
    take_screenshot
    PaperTrail.enabled = false
  end
end
