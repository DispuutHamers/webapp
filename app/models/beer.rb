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
     weight = (r.user.weight - r.rating).abs
     cijfer = cijfer + (r.rating * weight)
     avg = avg + weight
     puts "#{cijfer} + #{avg}"
   end
   return '%.2f' % (cijfer / avg) unless self.reviews.count == 0
 end 
 
end
