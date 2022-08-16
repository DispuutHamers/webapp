class Chugtype < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  has_rich_text :description
  has_many :chugs, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 500 }
end
