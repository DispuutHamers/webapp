require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @quote = Quote.new(user: @user, text: "Het mag ook een hele mooie, goed schoongemaakte penis zijn..", reporter: users(:two))
  end

  test 'valid quote' do
    assert @quote.valid?
  end

  test 'valid with existing reporter' do
    @quote.reporter = users(:two)
    assert @quote.valid?
  end

  test 'invalid without user' do
    @quote.user = nil
    refute @quote.valid?
  end

  test 'invalid if user does not exist' do
    @quote.user_id = -1
    refute @quote.valid?
  end

  test 'invalid if reporter does not exist' do
    @quote.reporter_id = -1
    refute @quote.valid?
  end

  test 'user can have multiple quotes' do
    @quote.save
    q2 = Quote.create(user: @user, text: "Quote 2", reporter: users(:two))
    q3 = Quote.create(user: @user, text: "Quote 3", reporter: users(:two))

    assert_includes @user.quotes, @quote
    assert_includes @user.quotes, q2
    assert_includes @user.quotes, q3
  end

  test 'delete quote' do
    @quote.save

    assert @quote.deleted_at.nil?
    @quote.delete
    refute @quote.deleted_at.nil?
  end

  test 'quote anonymous' do
    @quote.user = nil
    @quote.reporter = nil
    assert @quote.valid?
  end
end
