class Event < ActiveRecord::Base
 has_many :signups, dependent: :destroy
 belongs_to :user
end
