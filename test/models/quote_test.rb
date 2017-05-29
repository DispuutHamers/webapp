require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  test "Give user a quote" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    quote_text = "Turken doen aan eerwraak enzo. Negers swaffelen alleen maar"
    q = Quote.new
    q.text = quote_text
    q.user_id = u.id
    q.save!

    assert u.quotes[0].text == quote_text
  end

  test "Give multiple user multiple quotes" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    u2 = User.new
    u2.name = "Hamer Tester 2"
    u2.email = "hamertester2@zondersikkel.nl"
    u2.password = "hamers"
    u2.save!

    quote_text = "Turken doen aan eerwraak enzo. Negers swaffelen alleen maar"
    q = Quote.new
    q.text = quote_text
    q.user_id = u.id
    q.save!

    quote_text2 = "Het mag ook een hele mooie, goed schoongemaakte penis zijn..."
    q2 = Quote.new
    q2.text = quote_text2
    q2.user_id = u.id
    q2.save!

    quote_text3 = "Ik hou wel van enorme lullen. "
    q3 = Quote.new
    q3.text = quote_text3
    q3.user_id = u2.id
    q3.save!

    # newest quote goes on top
    assert u.quotes[0].text == quote_text2
    assert u.quotes[1].text == quote_text
    assert u2.quotes[0].text == quote_text3
  end

  test "Delete quote" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    quote_text = "Turken doen aan eerwraak enzo. Negers swaffelen alleen maar"
    q = Quote.new
    q.text = quote_text
    q.user_id = u.id
    q.save!

    assert q.deleted_at == nil
    q.delete
    assert q.deleted_at != nil
  end

end
