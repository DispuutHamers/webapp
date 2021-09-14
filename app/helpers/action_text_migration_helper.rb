# Module to help with migration of old fields to action texts,
# so that we can finally ditch the old columns.
module ActionTextMigrationHelper
  def eligible_reviews
    Review.all.with_rich_text_actiontext_description.where.not(description: [nil, ""])
  end

  def convert_reviews
    PaperTrail.request.disable_model(Review)

    eligible_reviews.each do |review|
      if review.actiontext_description.blank? && review.description
        # Default situation -> Store description as new actiontext_description
        review.update(actiontext_description: simple_format(review.description), description: nil)
      elsif review.actiontext_description && review.description
        #  Weird situation (both fields exist) -> Delete old description
        review.update(description: nil)
      end
    end

    PaperTrail.request.enable_model(Review)
  end
end
