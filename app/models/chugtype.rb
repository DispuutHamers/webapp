class Chugtype < ActiveRecord::Base
  has_paper_trail
  has_many :chugs
  has_rich_text :description
  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 500 }
end