class Meeting < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid

  has_many :drafts, as: :entity

  has_rich_text :actiontext_notes

  def save_draft(user)
    drafts.find_or_create_by(user: user).update(rich_data: actiontext_notes)
  end
end
