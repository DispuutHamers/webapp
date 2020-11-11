class Meeting < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees

  has_rich_text :actiontext_notes
end
