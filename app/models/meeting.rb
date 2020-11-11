class Meeting < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  has_and_belongs_to_many :users

  has_rich_text :actiontext_notes
end
