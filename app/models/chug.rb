class Chug < ActiveRecord::Base
  has_paper_trail
  belongs_to :chugtype
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  has_rich_text :comment

  scope :ordered, -> { order('secs DESC, milis DESC') }
end

