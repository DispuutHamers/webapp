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

    assert Beer.count == old_count + 3
  end

  test 'Review grade correctly' do
    b = Beer.create(percentage: '5.0%')

    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')
    u2 = User.create(name: 'Hamer Tester 2',
                     email: 'testhamer2@zondersikkel.nl',
                     password: 'Hamers')

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
    b = Beer.create(percentage: '5.0%')
    b2 = Beer.create(percentage: '8.0%')
    b3 = Beer.create(percentage: '6.4%')
    b4 = Beer.create(percentage: '11.0%')
    b5 = Beer.create(percentage: '3.8%')
    b6 = Beer.create(percentage: '0.0%')

    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')
    u2 = User.create(name: 'Hamer Tester 2',
                     email: 'testhamer2@zondersikkel.nl',
                     password: 'Hamers')

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
