class Blogitem < ApplicationRecord
  has_paper_trail on: [:update]
  serialize :body, :title
  has_many :blogphotos, dependent: :destroy

  def self.default_scope
    where("length(title) > 1")
  end
end
