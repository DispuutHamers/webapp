require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  test 'Add beer correctly' do
    old_amount = Beer.count

    b = Beer.new
    assert !b.save

    b.percentage = 'a'
    assert !b.save

    b.percentage = ''
    assert !b.save

    b.percentage = '5.0%'
    assert b.save

    b.percentage = '5'
    assert b.save

    b.percentage = '100.000'
    assert b.save

    assert Beer.count == old_amount + 1
  end

  test 'Review grade correctly' do
    b = Beer.new
    b.percentage = '5.0%'
    b.save

    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'testhamer@zondersikkel.nl'
    u.password = 'hamers'
    u.save

    u2 = User.new
    u2.name = 'Hamer Tester 2'
    u2.email = 'test2hamer@zondersikkel.nl'
    u2.password = 'hamers'
    u2.save

    # b.add_review(user, rating, description, proefdatum)
    b.add_review!(u, 8.0, 'Heel lekker biertje', 'Vandaag')
    u.update_weight
    b.update_cijfer
    assert b.cijfer? == 8.0

    b.add_review!(u2, 7.0, 'Vrij lekker biertje', 'Gisteren')
    u2.update_weight
    b.update_cijfer
    assert b.cijfer? == 7.5
  end

  test 'Review grade with weight' do
    b = Beer.new
    b.percentage = '5.0%'
    b.save

    b2 = Beer.new
    b2.percentage = '8.0%'
    b2.save

    b3 = Beer.new
    b3.percentage = '6.4%'
    b3.save

    b4 = Beer.new
    b4.percentage = '11.0%'
    b4.save

    b5 = Beer.new
    b5.percentage = '3.8%'
    b5.save

    b6 = Beer.new
    b6.percentage = '0.0%'
    b6.save

    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'testhamer@zondersikkel.nl'
    u.password = 'hamers'
    u.save

    u2 = User.new
    u2.name = 'Hamer Tester 2'
    u2.email = 'testhamer2@zondersikkel.nl'
    u2.password = 'hamers'
    u2.save

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
    b6.update_cijfer
  end

  test 'Review belongs to person' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'testhamer@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    b = Beer.new
    b.percentage = '5.0%'
    b.save!

    b.add_review!(u, 5.0, '', '')
    b.reviews.each do |r|
      assert r.user == u
    end
  end

  test 'Rating should be correct' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'testhamer@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    b = Beer.new
    b.percentage = '5.0%'
    b.save!

    assert_nothing_raised do
      b.add_review!(u, 5, '', '')
      b.add_review!(u, 1.0, '', '')
      b.add_review!(u, 10.0, '', '')
      b.add_review!(u, '5.', '', '')
      b.add_review!(u, '7.6', '', '')
      b.add_review!(u, '7.62345445', '', '')
    end

    assert_raise { b.add_review!(u, 50, '', '') }
    assert_raise { b.add_review!(u, 0, '', '') }
    assert_raise { b.add_review!(u, 'something', '', '') }
    assert_raise { b.add_review!(u, '', '', '') }
  end
end
