#Beer model
class Beer < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail :ignore => [:grade]
  has_many :reviews, dependent: :destroy
  VALID_PERCENTAGE_REGEX = /\d?\d(\.\d)?/
  validates :percentage, presence: true, format: {with: VALID_PERCENTAGE_REGEX}

  scope :random, -> { order('RAND()') }

  def cijfer?
    grade = self.grade
    if grade
      return grade.round(2)
    else
      return "Nog geen cijfer"
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
