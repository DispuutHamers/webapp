class Chugtype < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  has_rich_text :description
  has_many :chugs, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 32 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
