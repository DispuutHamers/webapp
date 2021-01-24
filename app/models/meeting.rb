class Meeting < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees

  has_many :drafts, as: :entity, dependent: :destroy

  has_rich_text :actiontext_notes

  def save_draft(user)
    drafts.find_or_create_by(user: user).update(rich_data: actiontext_notes)
  end
end
