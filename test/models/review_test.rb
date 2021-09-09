require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  setup do
    # New beer to rule out existing reviews interfering with our test.
    @beer = Beer.create(name: "Testbier")
    @user = users(:one)
  end

  test 'Create review' do

  end
end
