class Note < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
end
