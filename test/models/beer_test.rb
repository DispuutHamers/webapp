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
    u = users(:userthree)
    u2 = users(:userfour)

    b = beers(:beerone)
    # b.add_review(user, rating, description, proefdatum)
    b.add_review!(u, 8.0, 'Heel lekker biertje', 'Vandaag')
    u.update_weight
    b.update_cijfer
    assert_equal b.cijfer?, 8.0

    b.add_review!(u2, 7.0, 'Vrij lekker biertje', 'Gisteren')
    u2.update_weight
    b.update_cijfer
    assert_equal b.cijfer?, 7.5
  end

  test 'Review grade with weight' do
    u = users(:userone)
    u2 = users(:usertwo)

    b = beers(:beerone)
    b2 = beers(:beertwo)
    b3 = beers(:beerthree)
    b4 = beers(:beerfour)
    b5 = beers(:beerfive)
    b6 = beers(:beersix)
    # set weight of user u
    b.add_review!(u, 9.0, '', '')
    b2.add_review!(u, 9.0, '', '')
    b3.add_review!(u, 9.0, '', '')
    b4.add_review!(u, 9.0, '', '')

    # set weight of user u2
    b.add_review!(u2, 2.0, '', '')
    b2.add_review!(u2, 2.0, '', '')
    b3.add_review!(u2, 2.0, '', '')
    b4.add_review!(u2, 2.0, '', '')

    b5.add_review!(u, 8.0, '', '')
    b5.add_review!(u2, 9.0, '', '')
    b5.update_cijfer
    # what todo with the rating:
    #  keep it weighted or just average
    b6.add_review!(u, 8.0, '', '')
    b6.add_review!(u2, 2.0, '', '')
  end

  test 'Review belongs to person' do
    u = users(:userone)
    b = beers(:beerone)

    b.add_review!(u, 5.0, '', '')
    assert_equal b.reviews[0].user, u
  end

  test 'Rating should be correct' do
    u = users(:userone)
    b = beers(:beerone)

    assert_nothing_raised do
      b.add_review!(u, 5, '', '')
      b.add_review!(u, 1.0, '', '')
      b.add_review!(u, 10.0, '', '')
      b.add_review!(u, 5, '', '')
    end

    assert_raise { b.add_review!(u, 50, '', '') }
    assert_raise { b.add_review!(u, 0, '', '') }
    assert_raise { b.add_review!(u, 'something', '', '') }
    assert_raise { b.add_review!(u, '', '', '') }
    assert_raise { b.add_review!(u, 7.6, '', '') }
    assert_raise { b.add_review!(u, 7.62345445, '', '') }
  end
end
