# Module to help with migration of old fields to action texts,
# so that we can finally ditch the old columns.
module ActionTextMigrationHelper
  def eligible_meetings
    Meeting.all.with_rich_text_actiontext_notes.where.not(notes: [nil, ""])
  end

  def convert_meetings
    eligible_meetings.each do |meeting|
      if meeting.actiontext_notes.blank? && meeting.notes
        # Default situation -> Store notes as new actiontext_notes
        meeting.update(actiontext_notes: simple_format(meeting.notes), notes: nil)
      elsif meeting.actiontext_notes && meeting.notes
        #  Weird situation (both fields exist) -> Delete old notes
        meeting.update(notes: nil)
      end
    end
  end
end
