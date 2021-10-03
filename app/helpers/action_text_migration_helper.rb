# Module to help with migration of old fields to action texts,
# so that we can finally ditch the old columns.
module ActionTextMigrationHelper
  def eligible_blogitems
    Blogitem.all.with_rich_text_actiontext_body.where.not(body: [nil, ""])
  end

  def convert_blogitems
    PaperTrail.request.disable_model(Blogitem)

    eligible_blogitems.each do |blogitem|
      if blogitem.actiontext_body.blank? && blogitem.body
        # Default situation -> Store body as new actiontext_body
        blogitem.update(actiontext_body: simple_format(blogitem.body), body: nil)
      elsif blogitem.actiontext_body && blogitem.body
        #  Weird situation (both fields exist) -> Delete old body
        blogitem.update(body: nil)
      end
    end

    PaperTrail.request.enable_model(Blogitem)
  end
end
