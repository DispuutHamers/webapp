class Usergroup < ActiveRecord::Base
	acts_as_paranoid
  has_many :groups, foreign_key: 'group_id', dependent: :destroy
end
