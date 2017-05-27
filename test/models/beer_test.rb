require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  
  test "Beer percentage" do
    b = Beer.create
    assert (not b.save)

    
    b.percentage = "a"
    assert (not b.save)

    b.percentage = ""
    assert (not b.save)

    b.percentage = "5.0%"
    assert b.save

    b.percentage = "5"
    assert b.save

    b.percentage = "100.000"
    assert b.save
  end

  test "Review grade correctly" do
    b = Beer.create
    b.percentage = "5.0%"
    b.save

    u = User.create
    u.name = "Hamer Tester"
    u.email = "testhamer@zondersikkel.nl"
    u.password = "hamers"
    u.save

    
    u2 = User.create
    u2.name = "Hamer Tester 2"
    u2.email = "test2hamer@zondersikkel.nl"
    u2.password = "hamers"
    u2.save

    # b.add_review(user, rating, description, proefdatum)
    b.add_review!(u, 8.0, "Heel lekker biertje", "Vandaag")
    b.update_cijfer
    assert b.cijfer? == 8.0

    b.add_review!(u2, 7.0, "Vrij lekker biertje", "Gisteren")
    b.update_cijfer
    assert b.cijfer? == 7.53
  end

  test "Review grade with weight" do
    b = Beer.create
    b.percentage = "5.0%"
    b.save

    b2 = Beer.create
    b2.percentage = "8.0%"
    b2.save

    b3 = Beer.create
    b3.percentage = "6.4%"
    b3.save

    b4 = Beer.create
    b4.percentage = "11.0%"
    b4.save

    b5 = Beer.create
    b5.percentage = "3.8%"
    b5.save

    b6 = Beer.create
    b6.percentage = "0.0%"
    b6.save


    u = User.create
    u.name = "Hamer Tester"
    u.email = "testhamer@zondersikkel.nl"
    u.password = "hamers"
    u.save

    u2 = User.create
    u2.name = "Hamer Tester 2"
    u2.email = "testhamer2@zondersikkel.nl"
    u2.password = "hamers"
    u2.save

    # set weight of user u
    b.add_review!(u, 4.0, "", "")
    b2.add_review!(u, 4.0, "", "")
    b3.add_review!(u, 4.0, "", "")
    b4.add_review!(u, 4.0, "", "")

    # set weight of user u2
    b.add_review!(u2, 2.0, "", "")
    b2.add_review!(u2, 2.0, "", "")
    b3.add_review!(u2, 2.0, "", "")
    b4.add_review!(u2, 2.0, "", "")


    b5.add_review!(u, 9.0, "", "")
    b5.add_review!(u2, 2.0, "", "")
    b5.update_cijfer
    assert b5.cijfer? == 7.0
    # refer to the sheet in directory to see how it is calculated
    # formula:
    #  rating: ((person1rating * person1weight + person2rating * personweight + ...)
    #          / (person1weight + person2weight + ...)
    #    where the weight of a person is their average rating

    b.update_cijfer
    assert b.cijfer? == 3.43

    b2.update_cijfer
    b6.add_review!(u, 4.0, "", "")
    b6.add_review!(u2, 5.0, "", "")

    b6.update_cijfer
    assert b6.cijfer? == 4.34

    b2.update_cijfer
    b5.update_cijfer
    b6.update_cijfer
    assert b2.cijfer? == 3.32
    assert b5.cijfer? == 6.61
    assert b6.cijfer? == 4.34
  end

  test "Review belongs to person" do
    u = User.create
    u.name = "Hamer Tester"
    u.email = "testhamer@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    b = Beer.create
    b.percentage = "5.0%"
    b.save!

    b.add_review!(u, 5.0, "", "")
    b.reviews.each do |r|
      assert r.user == u
    end
  end

  test "Rating should be correct" do
    u = User.create
    u.name = "Hamer Tester"
    u.email = "testhamer@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    b = Beer.create
    b.percentage = "5.0%"
    b.save!

    assert_nothing_raised do
      b.add_review!(u, 5, "", "")
      b.add_review!(u, 1.0, "", "")
      b.add_review!(u, 10.0, "", "")
      b.add_review!(u, "5.", "", "")
      b.add_review!(u, "7.6", "", "")
      b.add_review!(u, "7.62345445", "", "")
    end

    assert_raise do   b.add_review!(u, 50, "" ,"")   end
    assert_raise do   b.add_review!(u, 0, "" ,"")   end
    assert_raise do   b.add_review!(u, "something", "" ,"")   end
    assert_raise do   b.add_review!(u, "", "" ,"")   end
  end
end
