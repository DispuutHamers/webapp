# Usergroup class
class Usergroup < ActiveRecord::Base
  acts_as_paranoid
  has_many :groups, foreign_key: 'group_id', dependent: :destroy
  has_many :users, through: :groups

  def empty?
    Group.where(group_id: id).count.zero?
  end
end
