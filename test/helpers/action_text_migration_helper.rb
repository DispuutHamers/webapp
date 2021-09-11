require 'test_helper'

# Rename to <>_test.rb to activate.
class ActionTextMigrationHelperTest < ActionView::TestCase
  setup do
    # Clear all current meetings
    Meeting.destroy_all

    # Setup data
    @user = users(:one)
    @meeting = Meeting.create(agenda: "Agenda", onderwerp: "Onderwerp")
  end

  # Test eligible_meetings method
  test 'works on meetings with actiontext_notes and notes' do
    assert_equal 0, eligible_meetings.count
    @meeting.notes = "Heeft oude notes"
    @meeting.actiontext_notes = "Heeft nieuwe actiontext_notes"
    @meeting.save
    assert_equal 1, eligible_meetings.count
  end

  test 'works on meetings without actiontext_notes but with notes' do
    assert_equal 0, eligible_meetings.count
    @meeting.notes = "Heeft oude notes"
    @meeting.save
    assert_nil @meeting.actiontext_notes
    assert_equal 1, eligible_meetings.count
  end

  test 'ignores meetings with actiontext_notes but without notes' do
    assert_equal 0, eligible_meetings.count
    @meeting.actiontext_notes = "Heeft nieuwe actiontext_notes"
    @meeting.save
    assert_nil @meeting.notes
    assert_equal 0, eligible_meetings.count
  end

  # Test actual conversion method
  test 'convert meetings without actiontext_notes and with notes' do
    @meeting.notes = "Oude notes"
    @meeting.save

    convert_meetings
    @meeting.reload

    assert_nil @meeting.notes
    assert_equal @meeting.actiontext_notes.to_plain_text, "Oude notes"
  end

  test 'deletes old notes if actiontext_notes exists' do
    @meeting.notes = "Exists"
    @meeting.actiontext_notes = "Exists also"
    @meeting.save

    convert_meetings
    @meeting.reload

    assert_nil @meeting.notes
    assert_equal @meeting.actiontext_notes.to_plain_text, "Exists also"
  end
end
