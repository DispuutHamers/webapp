class Beer < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail :ignore => [:grade]
  has_many :reviews, dependent: :destroy
  belongs_to :recipe
  belongs_to :chugtype
  has_one_attached :image
  VALID_PERCENTAGE_REGEX = /\d?\d(\.\d)?/
  validates :percentage, allow_blank: true, format: {with: VALID_PERCENTAGE_REGEX}

  scope :random, -> { order('RANDOM()') }

  def cijfer
    self.grade&.round(2) || "Nog geen cijfer"
  end

  def update_cijfer
    avg, cijfer = 0.0, 0.0
    self.reviews.each do |r|
      weight = 1 + (r.user.weight - r.rating).abs
      cijfer = cijfer + (r.rating * weight)
      avg = avg + weight
    end

    self.grade = cijfer / avg unless avg == 0.0
    self.save
  end

  def to_s
    name
  end
end
