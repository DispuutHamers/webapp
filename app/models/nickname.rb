class Nickname < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
end
