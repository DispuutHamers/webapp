class Beer < ActiveRecord::Base
 has_many :reviews
 
 def add_review!(user, rating, description)
   self.reviews.create!(user_id: user.id, rating: rating, description: description)
 end
 
end
