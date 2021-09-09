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

  # Test eligble_events method
  test 'works on events with description and beschrijving' do
    assert_equal 0, eligible_events.count
    @event.beschrijving = "Heeft oude beschrijving"
    @event.description = "Heeft nieuwe description"
    @event.save
    assert_equal 1, eligible_events.count
  end

  test 'works on events without description but with beschrijving' do
    assert_equal 0, eligible_events.count
    @event.beschrijving = "Heeft oude beschrijving"
    @event.save
    assert_nil @event.description
    assert_equal 1, eligible_events.count
  end

  test 'ignores events with description but without beschrijving' do
    assert_equal 0, eligible_events.count
    @event.description = "Heeft nieuwe description"
    @event.save
    assert_nil @event.beschrijving
    assert_equal 0, eligible_events.count
  end

  # Test actual conversion method
  test 'convert events without description and with beschrijving' do
    @event.beschrijving = "Oude beschrijving"
    @event.save

    convert_events
    @event.reload

    assert_nil @event.beschrijving
    assert_equal @event.description.to_plain_text, "Oude beschrijving"
  end

  test 'deletes old beschrijving if description exists' do
    @event.beschrijving = "Exists"
    @event.description = "Exists also"
    @event.save

    convert_events
    @event.reload

    assert_nil @event.beschrijving
    assert_equal @event.description.to_plain_text, "Exists also"
  end
end
