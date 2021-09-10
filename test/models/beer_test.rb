require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  setup do
    @beer = Beer.new(name: "Leffe Blond", soort: "Blond", brewer: "Leffe", country: "België", percentage: "6.6 %")
  end

  test 'valid beer' do
    assert @beer.valid?
  end

  test 'beer does have versions (papertrail)' do
    assert_nothing_raised { @beer.versions }

    with_versioning do
      @beer.save
      assert_equal 1, @beer.versions.count
    end
  end

  test 'beer has new version when name changes' do
    with_versioning do
      @beer.save
      assert_difference '@beer.versions.count', 1 do
        @beer.name = "Changed name"
        @beer.save
      end
    end
  end

  test 'beer has new version when soort changes' do
    with_versioning do
      @beer.save
      assert_difference '@beer.versions.count', 1 do
        @beer.soort = "Changed soort"
        @beer.save
      end
    end
  end

  test 'beer has new version when brewer changes' do
    with_versioning do
      @beer.save
      assert_difference '@beer.versions.count', 1 do
        @beer.brewer = "Changed brewer"
        @beer.save
      end
    end
  end

  test 'beer has new version when country changes' do
    with_versioning do
      @beer.save
      assert_difference '@beer.versions.count', 1 do
        @beer.country = "Changed country"
        @beer.save
      end
    end
  end

  test 'beer has new version when percentage changes' do
    with_versioning do
      @beer.save
      assert_difference '@beer.versions.count', 1 do
        @beer.percentage = 1.0
        @beer.save
      end
    end
  end

  test 'beer does not have a new version when grade changes' do
    with_versioning do
      @beer.save
      assert_no_difference '@beer.versions.count' do
        @beer.grade = 6
        @beer.save
      end
    end
  end
end
