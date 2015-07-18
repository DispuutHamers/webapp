class Beer < ActiveRecord::Base
 has_many :reviews
 VALID_PERCENTAGE_REGEX = /\d?\d\.\d?%/i
 validates :percentage, presence: true, format: { with: VALID_PERCENTAGE_REGEX }
 
 def add_review!(user, rating, description, proefdatum)
   self.reviews.create!(user_id: user.id, rating: rating, description: description, proefdatum: proefdatum)
 end
 
 def cijfer?
   cijfer = 0.0
   avg = 0.0
   self.reviews.each do |r| 
     cijfer = cijfer + (r.rating * r.user.weight)
     avg = avg + r.user.weight
   end
   return (cijfer / avg) unless self.reviews.count == 0
 end 
 
end
