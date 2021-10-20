# Usergroup class
class Usergroup < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  has_many :groups, foreign_key: 'group_id', dependent: :destroy
  has_many :users, through: :groups
  has_many :events
  has_one_attached :logo

  validates :signal_url, format: URI::regexp('https'), allow_blank: true

  def empty?
    groups.count.zero?
  end

  def old_members
    user_ids = groups.only_deleted.pluck(:user_id)
    User.where(id: user_ids)
  end
end
