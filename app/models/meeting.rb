class Meeting < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid

  has_rich_text :actiontext_notes
end
