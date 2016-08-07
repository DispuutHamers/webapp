class Beer < ActiveRecord::Base
	acts_as_paranoid
  has_many :reviews
   VALID_PERCENTAGE_REGEX = /\d?\d(\.\d)?/
  validates :percentage, presence: true, format: {with: VALID_PERCENTAGE_REGEX}

  def add_review!(user, rating, description, proefdatum)
    self.reviews.create!(user_id: user.id, rating: rating, description: description, proefdatum: proefdatum)
  end
  def cijfer?
    return self.grade
  end

  def update_cijfer
    cijfer = 0.0
    avg = 0.0
    self.reviews.each do |r|
      weight = 1 + (r.user.weight - r.rating).abs
      cijfer = cijfer + (r.rating * weight)
      avg = avg + weight
    end
    self.grade = cijfer / avg unless avg == 0.0
    self.save
  end

	def	as_json(options)
	  h = super({:only => [:id, :name, :soort, :picture, :created_at, :percentage, :brewer, :country, :URL]}.merge(options))
		h[:cijfer] = cijfer?
		h
	end
end
