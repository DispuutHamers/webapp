class ApiKey < ActiveRecord::Base
	acts_as_paranoid
  belongs_to :user
  has_many :api_logs, :foreign_key => 'key'
end
