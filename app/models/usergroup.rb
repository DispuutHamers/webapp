# Usergroup class
class Usergroup < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  has_many :groups, foreign_key: 'group_id', dependent: :destroy
  has_many :users, through: :groups
  has_many :events
  has_one_attached :logo

  def empty?
    Group.where(group_id: id).count.zero?
  end

  def old_members
    Group.where(group_id: id).with_deleted
  end
end
