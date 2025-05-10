# Usergroup class
class Usergroup < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  belongs_to :user
  has_many :groups, foreign_key: 'group_id', dependent: :destroy
  has_many :users, through: :groups
  has_many :events
  has_one_attached :logo

  validates :name, presence: true, length: { maximum: 64 }
  validates :description, length: { maximum: 256 }
  validates :logo, content_type: %w[image/png image/jpeg], aspect_ratio: :square
  validates :signal_url, format: URI::regexp('https'), allow_blank: true
  validates :archived, inclusion: { in: [true, false] }

  scope :archived, -> { where(archived: true) }
  scope :not_archived, -> { where(archived: false) }

  def empty?
    groups.count.zero?
  end

  def old_members
    user_ids = groups.only_deleted.pluck(:user_id)
    User.where(id: user_ids)
  end

  def to_s
    name
  end
end

