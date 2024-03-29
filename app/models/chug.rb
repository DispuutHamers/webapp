class Chug < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  belongs_to :chugtype
  belongs_to :user
  belongs_to :reporter, class_name: "User"

  validates :chugtype, presence: true
  validates :user, presence: true
  validates :reporter, presence: true
  validates :time, presence: true, numericality: { greater_than_or_equal_to: 0.0, less_than: 1000.0 }
  validates :comment, length: { maximum: 500 }
  validate :reporter_and_user_differ

  scope :newest, -> chugtype { where(chugtype: chugtype).order('created_at DESC') }
  scope :unique_not_extern, -> chugtype { where(chugtype: chugtype).order('time ASC, created_at ASC').uniq { |chug| chug.user }.reject { |chug| chug.user.id == 7 } }
  scope :extern, -> chugtype { where(chugtype: chugtype).select { |chug| chug.user.id == 7 } }

  private

  def reporter_and_user_differ
    return unless reporter_id == user_id

    errors.add(:user, ": Je gaat toch niet je eigen tijd noteren!")
  end
end
