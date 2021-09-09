# Module to help with migration of old fields to action texts,
# so that we can finally ditch the old columns.
# Note to self: description is the new field, beschrijving the old one.
module ActionTextMigrationHelper
  def eligible_events
    Event.all.with_rich_text_description.where.not(beschrijving: [nil, ""])
  end

  def convert_events
    eligible_events.each do |event|
      if event.description.blank? && event.beschrijving
        # Default situation -> Store beschrijving as new description
        event.update(description: simple_format(event.beschrijving),
                     beschrijving: nil)
      elsif event.description && event.beschrijving
        #  Weird situation (both fields exist) -> Delete old beschrijving
        event.update(beschrijving: nil)
      end
    end
  end
end
