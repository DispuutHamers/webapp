# Usergroup class
class Usergroup < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  has_many :groups, foreign_key: 'group_id', dependent: :destroy
  has_many :users, through: :groups

  def empty?
    Group.where(group_id: id).count.zero?
  end

  def as_json
    super(only: [:id, :name])
  end
end
