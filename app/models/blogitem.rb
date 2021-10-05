class Blogitem < ApplicationRecord
  has_paper_trail on: [:update]
  serialize :body
  serialize :title
  has_many :blogphotos, dependent: :destroy
  belongs_to :user

  has_rich_text :body
  
  def self.default_scope
    where("length(title) > 1")
  end
end
