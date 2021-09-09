# Module to help with migration of old fields to action texts,
# so that we can finally ditch the old columns.
# Note to self: description is the new field, beschrijving the old one.
module ActionTextMigrationHelper
  def eligible_events
    Event.all.with_rich_text_description.where.not(beschrijving: [nil, ""])
  end

  def convert_events
    eligible_events.each do |event|
      # Default situation -> Store beschrijving as new description
      if event.description.blank? && !event.beschrijving.nil?
        p "CONVERSION!"
        event.update_attribute(:description, simple_format(event.beschrijving))
        event.update_attribute(:beschrijving, nil)
      end
    end
  end
end
