class PublicPage < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  has_rich_text :content
  has_rich_text :actiontext_content

  before_save do
    self.content = self.actiontext_content
    self.actiontext_content.destroy
  end
end
