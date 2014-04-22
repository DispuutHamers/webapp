class Beer < ActiveRecord::Base
 has_many :reviews
 
 def add_review!(user, rating, description, proefdatum)
   self.reviews.create!(user_id: user.id, rating: rating, description: description, proefdatum: proefdatum)
 end
 
 def cijfer?
   cijfer = 0
   self.reviews.each do |r| 
     cijfer = cijfer + r.rating
   end
   return (cijfer / self.reviews.count) unless self.reviews.count == 0
 end 
 
end
