class Event < ActiveRecord::Base
 has_many :signups, dependent: :destroy
end
