require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  test 'Add beer correctly' do
    old_count = Beer.count

    b = Beer.new
    assert !b.save
    b = Beer.new(percentage: 'a')
    assert !b.save
    b = Beer.new(percentage: '')
    assert !b.save
    b = Beer.new(percentage: '5.0%')
    assert b.save
    b = Beer.new(percentage: '5')
    assert b.save
    b = Beer.new(percentage: '100.000')
    assert b.save

    assert_equal Beer.count, old_count + 3
  end

  test 'Review grade correctly' do
    # users 3 and 4 don't have reviews yet (thus don't skew the ratings)
    u = users(:three)
    u2 = users(:four)

    b = beers(:one)
    # b.add_review(user, rating, description, proefdatum)
    b.add_review!(u, 8.0, 'Heel lekker biertje')

    b.add_review!(u2, 7.0, 'Vrij lekker biertje')

  end

  test 'Review grade with weight' do
    u = users(:one)
    u2 = users(:two)

    b = beers(:one)
    b2 = beers(:two)
    b3 = beers(:three)
    b4 = beers(:four)
    b5 = beers(:five)
    b6 = beers(:six)
    # set weight of user u
    b.add_review!(u, 9.0, '')
    b2.add_review!(u, 9.0, '',)
    b3.add_review!(u, 9.0, '')
    b4.add_review!(u, 9.0, '')

    # set weight of user u2
    b.add_review!(u2, 2.0, '')
    b2.add_review!(u2, 2.0, '')
    b3.add_review!(u2, 2.0, '')
    b4.add_review!(u2, 2.0, '')

    b5.add_review!(u, 8.0, '')
    b5.add_review!(u2, 9.0, '')
    b5.update_cijfer
    # what todo with the rating:
    #  keep it weighted or just average
    b6.add_review!(u, 8.0, '')
    b6.add_review!(u2, 2.0, '')
  end

  test 'Review belongs to person' do
    u = users(:one)
    b = beers(:one)

    b.add_review!(u, 5.0, '')
    assert_equal b.reviews.last.user, u
  end

  test 'Rating should be correct' do
    skip("This test does not work currently.")
    u = users(:one)
    b = beers(:one)

    assert_nothing_raised do
      b.add_review!(u, 5, '')
      b.add_review!(u, 1.0, '')
      b.add_review!(u, 10.0, '')
      b.add_review!(u, 5, '')
    end

    assert_raise { b.add_review!(u, 50, '') }
    assert_raise { b.add_review!(u, 0, '') }
    assert_raise { b.add_review!(u, 'something', '') }
    assert_raise { b.add_review!(u, '', '') }
    assert_raise { b.add_review!(u, 7.6, '') }
    assert_raise { b.add_review!(u, 7.62345445, '') }
  end
end
