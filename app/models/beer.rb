#Beer model
class Beer < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail :ignore => [:grade]
  has_many :reviews
  VALID_PERCENTAGE_REGEX = /\d?\d(\.\d)?/
  validates :percentage, presence: true, format: {with: VALID_PERCENTAGE_REGEX}

  scope :random, -> { order('RAND()') }

  # This method is (only) used in the tests
  def add_review!(user, rating, description, proefdatum)
    self.reviews.create!(user_id: user.id, rating: rating.round, description: description, proefdatum: proefdatum)
  end

  def cijfer?
    grade = self.grade
    if grade
      return grade.round(2)
    else
      return "No grade"
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
