# Module to help with migration of old fields to action texts,
# so that we can finally ditch the old columns.
# Note to self: description is the new field, beschrijving the old one.
module ActionTextMigrationHelper
  def find_eligible_events
    events = Event.all.with_rich_text_description
    events = events.where.not(beschrijving: [nil, ""])

    events.count
  end

  def convert_event_description_to_action_text

  end
end
