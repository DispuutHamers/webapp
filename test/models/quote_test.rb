require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  test 'Add a quote' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    old_count = Quote.count

    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    Quote.create(text: quote_text, user_id: u.id)

    assert Quote.count == old_count + 1
  end
  test 'Give user a quote' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    Quote.create(text: quote_text, user_id: u.id)

    assert u.quotes[0].text == quote_text
  end

  test 'Give multiple user multiple quotes' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')
    u2 = User.create(name: 'Hamer Tester 2',
                     email: 'testhamer2@zondersikkel.nl',
                     password: 'Hamers')
    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    Quote.create(text: quote_text, user_id: u.id)
    quote_text2 = 'Het mag ook een hele mooie, goed schoongemaakte penis zijn..'
    Quote.create(text: quote_text2, user_id: u.id)
    quote_text3 = 'Ik hou wel van enorme lullen. '
    Quote.create(text: quote_text3, user_id: u2.id)

    # newest quote goes on top
    assert u.quotes[0].text == quote_text2
    assert u.quotes[1].text == quote_text
    assert u2.quotes[0].text == quote_text3
  end

  test 'Delete quote' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    q = Quote.create(text: quote_text, user_id: u.id)

    assert q.deleted_at.nil?
    q.delete
    assert !q.deleted_at.nil?
  end
end
