#Beer model
class Beer < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail :ignore => [:grade]
  has_many :reviews
  VALID_PERCENTAGE_REGEX = /\d?\d(\.\d)?/
  validates :percentage, presence: true, format: {with: VALID_PERCENTAGE_REGEX}

  def add_review!(user, rating, description, proefdatum)
    if not check_rating(rating)
      raise "Incorrect rating, should be between 1.0 and 10.0"
    end
    self.reviews.create!(user_id: user.id, rating: rating, description: description, proefdatum: proefdatum)
  end

  def check_rating(rating)
    if not (rating.is_a?(Float)) or (rating.is_a?(Integer))
      if rating.to_f < 1.0 or rating.to_f > 10.0
        return false
      end
    end
    return true
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

  def as_json(options)
    h = super({:only => [:id, :name, :soort, :picture, :created_at, :percentage, :brewer, :country, :URL]}.merge(options))
    h[:cijfer] = cijfer?
    h
  end
end
