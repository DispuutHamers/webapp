# Module to help with migration of old fields to action texts,
# so that we can finally ditch the old columns.
module ActionTextMigrationHelper
  def eligible_meetings
    Meeting.all.with_rich_text_actiontext_notes.where.not(notes: [nil, ""])
  end

  def convert_meetings
    eligible_meetings.each do |meeting|
      if meeting.description.blank? && meeting.beschrijving
        # Default situation -> Store beschrijving as new description
        meeting.update(description: simple_format(meeting.beschrijving),
                     notes: nil)
      elsif meeting.description && meeting.beschrijving
        #  Weird situation (both fields exist) -> Delete old beschrijving
        meeting.update(notes: nil)
      end
    end
  end
end
