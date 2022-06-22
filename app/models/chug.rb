class Chug < ActiveRecord::Base
  has_paper_trail
  belongs_to :chugtype
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  has_rich_text :comment
end