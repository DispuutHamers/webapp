class Review < ActiveRecord::Base
  has_paper_trail
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, only_integer: true }
  belongs_to :user
  belongs_to :beer
  acts_as_paranoid

  scope :with_user, -> { includes(:user) }

  def as_json(options)
    super({:only => [:id, :beer_id, :user_id, :description, :rating, :proefdatum, :created_at]}.merge(options))
  end
end
