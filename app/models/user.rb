class User < ActiveRecord::Base
  has_many :quotes
end
