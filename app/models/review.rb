class Review < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  belongs_to :beer
  validates :user, uniqueness: {scope: [:user, :beer]}, presence: true
  validates :beer, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, only_integer: true }
  after_initialize :set_proefdatum

  has_rich_text :actiontext_description
  has_rich_text :description
  
  before_save do
    self.description = self.actiontext_description
    self.actiontext_description.destroy
  end

  scope :with_user, -> { includes(:user) }

  def set_proefdatum
    self.proefdatum ||= Date.today
  end
end
