class Chugtype < ActiveRecord::Base
  has_paper_trail
  has_many :chugs
  has_rich_text :description
end