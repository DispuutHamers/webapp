class Group < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  belongs_to :usergroup, class_name: "Usergroup", foreign_key: 'group_id'

  validates :user_id, presence: true
  validates :group_id, presence: true

end
