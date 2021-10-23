require 'application_system_test_case'

class TrailPageTest < ApplicationSystemTestCase
  def setup
    PaperTrail.enabled = true

    sign_in(User.first)
  end

  test 'quote create' do
    Quote.create(user: users(:one), text: "Nieuwe quote", reporter: users(:two))
    visit trail_path

    assert_selector "p", text: "citeerde Hamer Tester"
  end

  test 'quote destroy' do
    Quote.first.destroy
    visit trail_path


    assert_selector "p", text: "verwijderde quote"
  end

  def teardown
    take_screenshot
    PaperTrail.enabled = false
  end
end
