class Meeting < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :chairman, class_name: "User"
  belongs_to :secretary, class_name: "User"
  has_many :attendees
  has_many :users, through: :attendees
  has_many :drafts, as: :entity, dependent: :destroy

  has_rich_text :agenda_rt
  has_rich_text :notes

  before_save do
    self.agenda_rt = ApplicationController.helpers.simple_format(self.agenda)
  end

  def save_draft(user)
    drafts.find_or_create_by(user: user).update(rich_data: notes)
  end
end
