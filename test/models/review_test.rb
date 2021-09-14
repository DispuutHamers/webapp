require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    # New beer to rule out existing reviews interfering with our test.
    @beer = Beer.new(name: "Testbier")
    @review = Review.new(beer: @beer, user: @user, rating: 8, description: "Goed bier.")
  end

  test 'valid review' do
    assert @review.valid?
  end

  test 'invalid without user' do
    @review.user = nil
    refute @review.valid?
  end

  test 'invalid without beer' do
    @review.beer = nil
    refute @review.valid?
  end

  test 'invalid without rating' do
    @review.rating = nil
    refute @review.valid?
  end

  test 'invalid with float rating' do
    @review.rating = 5.5
    refute @review.valid?
  end

  test 'invalid with rating of 0' do
    @review.rating = 0
    refute @review.valid?
  end

  test 'invalid with negative rating' do
    @review.rating = 0
    refute @review.valid?
  end

  test 'invalid with rating higher than 10' do
    @review.rating = 11
    refute @review.valid?
  end

  test 'invalid if review for beer+user already exists' do
    @review.save

    second_review = Review.new(beer: @beer, user: @user, rating: 8)
    refute second_review.valid?
  end

  test 'invalid if user does not exist' do
    @review.user_id = -1
    refute @review.valid?
  end

  test 'invalid if beer does not exist' do
    @review.beer_id = -1
    refute @review.valid?
  end
end
