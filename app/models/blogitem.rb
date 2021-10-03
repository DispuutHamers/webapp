class Blogitem < ApplicationRecord
  has_paper_trail on: [:update]
  serialize :body
  serialize :title
  validates :title, presence: true
  has_many :blogphotos, dependent: :destroy
  belongs_to :user

  has_rich_text :actiontext_body
  
  def self.default_scope
    where("length(title) > 1")
  end
end
