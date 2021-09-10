require 'test_helper'

# Rename to <>_test.rb to activate.
class ActionTextMigrationHelperTest < ActionView::TestCase
  setup do
    # Clear all current meetings
    Meeting.destroy_all

    # Setup data
    @user = users(:one)
    @meeting = Event.create(title: 'Example event',
                          date: DateTime.now + 1.day,
                          end_time: DateTime.now + 1.day + 2.hours,
                          deadline: DateTime.now + 5,
                          user: @user)
  end

  # Test eligble_events method
  test 'works on events with description and beschrijving' do
    assert_equal 0, eligible_meetings.count
    @meeting.beschrijving = "Heeft oude beschrijving"
    @meeting.description = "Heeft nieuwe description"
    @meeting.save
    assert_equal 1, eligible_meetings.count
  end

  test 'works on events without description but with beschrijving' do
    assert_equal 0, eligible_meetings.count
    @meeting.beschrijving = "Heeft oude beschrijving"
    @meeting.save
    assert_nil @meeting.description
    assert_equal 1, eligible_meetings.count
  end

  test 'ignores events with description but without beschrijving' do
    assert_equal 0, eligible_meetings.count
    @meeting.description = "Heeft nieuwe description"
    @meeting.save
    assert_nil @meeting.beschrijving
    assert_equal 0, eligible_meetings.count
  end

  # Test actual conversion method
  test 'convert events without description and with beschrijving' do
    @meeting.beschrijving = "Oude beschrijving"
    @meeting.save

    convert_events
    @meeting.reload

    assert_nil @meeting.beschrijving
    assert_equal @meeting.description.to_plain_text, "Oude beschrijving"
  end

  test 'deletes old beschrijving if description exists' do
    @meeting.beschrijving = "Exists"
    @meeting.description = "Exists also"
    @meeting.save

    convert_events
    @meeting.reload

    assert_nil @meeting.beschrijving
    assert_equal @meeting.description.to_plain_text, "Exists also"
  end
end
