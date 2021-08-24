require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  test 'Add a quote' do
    u = users(:one)

    old_count = Quote.count

    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    Quote.create(text: quote_text, user_id: u.id)

    assert_equal Quote.count, old_count + 1
  end

  test 'Give user a quote' do
    u = users(:one)

    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    Quote.create(text: quote_text, user_id: u.id)

    assert_equal u.quotes[0].text, quote_text
  end

  test 'Give multiple user multiple quotes' do
    # users three and four don't have quotes
    u = users(:one)
    u2 = users(:two)

    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    q = Quote.create(text: quote_text, user_id: u.id)
    quote_text2 = 'Het mag ook een hele mooie, goed schoongemaakte penis zijn..'
    q2 = Quote.create(text: quote_text2, user_id: u.id)
    quote_text3 = 'Ik hou wel van enorme lullen. '
    q3 = Quote.create(text: quote_text3, user_id: u2.id)

    assert_includes u.quotes, q
    assert_includes u.quotes, q2
    assert_includes u2.quotes, q3
  end

  test 'Delete quote' do
    u = users(:one)

    quote_text = 'Turken doen aan eerwraak enzo. Negers swaffelen alleen maar'
    q = Quote.create(text: quote_text, user_id: u.id)

    assert q.deleted_at.nil?
    q.delete
    assert !q.deleted_at.nil?
  end
end
