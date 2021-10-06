class Blogitem < ApplicationRecord
  has_paper_trail on: [:update]
  serialize :body
  serialize :title
  has_many :blogphotos, dependent: :destroy
  belongs_to :user

  scope :public_blogs, -> { where(public: true) }

  has_rich_text :body
end
