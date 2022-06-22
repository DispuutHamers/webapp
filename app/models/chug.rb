class Chug < ActiveRecord::Base
  has_paper_trail
  belongs_to :chug_type
  has_rich_text :comment
end