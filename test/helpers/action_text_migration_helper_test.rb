require 'test_helper'

class ActionTextMigrationHelperTest < ActionView::TestCase
  setup do
    # Clear all current events
    Event.destroy_all

    # Setup data
    @user = users(:one)
    @event = Event.create(title: 'Example event',
                          date: DateTime.now + 1.day,
                          end_time: DateTime.now + 1.day + 2.hours,
                          deadline: DateTime.now + 5,
                          user: @user)
  end

  test 'works on events with description and beschrijving' do
    assert_equal 0, find_eligible_events
    @event.beschrijving = "Heeft oude beschrijving"
    @event.description = "Heeft nieuwe description"
    @event.save
    assert_equal 1, find_eligible_events
  end

  test 'works on events without description but with beschrijving' do
    assert_equal 0, find_eligible_events
    @event.beschrijving = "Heeft oude beschrijving"
    @event.save
    assert_nil @event.description
    assert_equal 1, find_eligible_events
  end

  test 'ignores events with description but without beschrijving' do
    assert_equal 0, find_eligible_events
    @event.description = "Heeft nieuwe description"
    @event.save
    assert_nil @event.beschrijving
    assert_equal 0, find_eligible_events
  end
end
