class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :usergroup
  validates :user_id, presence: true
  validates :group_id, presence: true

end
