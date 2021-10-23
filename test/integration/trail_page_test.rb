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
      q = Quote.first
      q.reporter = users(:three)
      q.save!
      visit trail_path

      assert_selector "p", text: "wijzigde een citaat van Hamer Tester"
    end

    should 'destroy' do
      Quote.first.destroy
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

  def teardown
    take_screenshot
    PaperTrail.enabled = false
  end
end
