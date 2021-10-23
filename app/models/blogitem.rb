class Blogitem < ApplicationRecord
  Gutentag::ActiveRecord.call self

  has_paper_trail
  serialize :body
  serialize :title
  belongs_to :user

  scope :public_blogs, -> { where(public: true) }

  has_rich_text :body

  def tags_as_string
    tag_names.join(', ')
  end

  # Split up the provided value by commas and (optional) spaces.
  def tags_as_string=(string)
    self.tag_names = string.split(/,\s*/)
  end
end
