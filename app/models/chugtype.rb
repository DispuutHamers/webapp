class Chugtype < ActiveRecord::Base
  has_paper_trail
  has_many :chugs
  has_rich_text :description
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, length: { maximum: 500 }
end