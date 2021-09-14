require 'test_helper'

# Rename to <>_test.rb to activate.
class ActionTextMigrationHelperTest < ActionView::TestCase
  setup do
    # Clear all current reviews
    Review.destroy_all

    # Setup data
    @user = users(:one)
    @beer = Beer.create(name: "Testbier", percentage: 0)
    @review = Review.create(user: @user, beer: @beer, rating: 1)
  end

  # Test eligible_reviews method
  test 'works on reviews with actiontext_description and description' do
    assert_equal 0, eligible_reviews.count
    @review.description = "Heeft oude description"
    @review.actiontext_description = "Heeft nieuwe actiontext_description"
    @review.save
    assert_equal 1, eligible_reviews.count
  end

  test 'works on reviews without actiontext_description but with description' do
    assert_equal 0, eligible_reviews.count
    @review.description = "Heeft oude description"
    @review.save
    assert_nil @review.actiontext_description
    assert_equal 1, eligible_reviews.count
  end

  test 'ignores reviews with actiontext_description but without description' do
    assert_equal 0, eligible_reviews.count
    @review.actiontext_description = "Heeft nieuwe actiontext_description"
    @review.save
    assert_nil @review.description
    assert_equal 0, eligible_reviews.count
  end

  # Test actual conversion method
  test 'convert reviews without actiontext_description and with description' do
    @review.description = "Oude description"
    @review.save

    convert_reviews
    @review.reload

    assert_nil @review.description
    assert_equal @review.actiontext_description.to_plain_text, "Oude description"
  end

  test 'deletes old description if actiontext_description exists' do
    @review.description = "Exists"
    @review.actiontext_description = "Exists also"
    @review.save

    convert_reviews
    @review.reload

    assert_nil @review.description
    assert_equal @review.actiontext_description.to_plain_text, "Exists also"
  end
end
