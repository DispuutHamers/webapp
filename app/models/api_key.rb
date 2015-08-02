class ApiKey < ActiveRecord::Base
	belongs_to :user
	has_many :api_logs, :foreign_key => "key"
end
