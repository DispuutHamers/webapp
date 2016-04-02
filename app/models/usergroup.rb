class Usergroup < ActiveRecord::Base
  has_many :groups, foreign_key: 'group_id', dependent: :destroy
end
