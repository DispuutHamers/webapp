class Review < ActiveRecord::Base
  has_paper_trail
  validates :rating, presence: true
  belongs_to :user
  belongs_to :beer
  acts_as_paranoid

  def as_json(options)
    super({:only => [:id, :beer_id, :user_id, :description, :rating, :proefdatum, :created_at]}.merge(options))
  end
end
