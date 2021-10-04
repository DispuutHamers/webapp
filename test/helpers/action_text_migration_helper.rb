require 'test_helper'

# Rename to <>_test.rb to activate.
class ActionTextMigrationHelperTest < ActionView::TestCase
  setup do
    # Clear all current reviews
    Blogitem.destroy_all

    # Setup data
    @user = users(:one)
    @blogitem = Blogitem.create(user: @user, title: "boeitniet")
  end

  # Test eligible_blogitems method
  test 'works on reviews with actiontext_body and body' do
    assert_equal 0, eligible_blogitems.count
    @blogitem.body = "Heeft oude body"
    @blogitem.actiontext_body = "Heeft nieuwe actiontext_body"
    @blogitem.save
    assert_equal 1, eligible_blogitems.count
  end

  test 'works on reviews without actiontext_body but with body' do
    assert_equal 0, eligible_blogitems.count
    @blogitem.body = "Heeft oude body"
    @blogitem.save
    assert_nil @blogitem.actiontext_body
    assert_equal 1, eligible_blogitems.count
  end

  test 'ignores reviews with actiontext_body but without body' do
    assert_equal 0, eligible_blogitems.count
    @blogitem.actiontext_body = "Heeft nieuwe actiontext_body"
    @blogitem.save
    assert_nil @blogitem.body
    assert_equal 0, eligible_blogitems.count
  end

  # Test actual conversion method
  test 'convert reviews without actiontext_body and with body' do
    @blogitem.body = "Oude body"
    @blogitem.save

    convert_blogitems
    @blogitem.reload

    assert_nil @blogitem.body
    assert_equal @blogitem.actiontext_body.to_plain_text, "Oude body"
  end

  test 'deletes old body if actiontext_body exists' do
    @blogitem.body = "Exists"
    @blogitem.actiontext_body = "Exists also"
    @blogitem.save

    convert_blogitems
    @blogitem.reload

    assert_nil @blogitem.body
    assert_equal @blogitem.actiontext_body.to_plain_text, "Exists also"
  end
end
