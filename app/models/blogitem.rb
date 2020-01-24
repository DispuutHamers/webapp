class Blogitem < ApplicationRecord
  has_paper_trail on: [:update]
  serialize :body
  serialize :title
  has_many :blogphotos, dependent: :destroy

  has_rich_text :actiontext_body
  
  def self.default_scope
    where("length(title) > 1")
  end
end
