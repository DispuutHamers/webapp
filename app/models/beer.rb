#Beer model
class Beer < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail :ignore => [:grade]
  has_many :reviews
  VALID_PERCENTAGE_REGEX = /\d?\d(\.\d)?/
  validates :percentage, presence: true, format: {with: VALID_PERCENTAGE_REGEX}

  scope :random, -> { order('RAND()') }
  def add_review!(user, rating, description, proefdatum)
    self.reviews.create!(user_id: user.id, rating: rating, description: description, proefdatum: proefdatum)
  end

  def cijfer?
    grade = self.grade
    if grade
      grade.round(2)
    else
      "No grade"
    end
  end

  def update_cijfer
    avg,cijfer = 0.0,0.0
    self.reviews.each do |r|
      weight = 1 + (r.user.weight - r.rating).abs
      cijfer = cijfer + (r.rating * weight)
      avg = avg + weight
    end

    self.grade = cijfer / avg unless avg == 0.0
    self.save
  end
end
