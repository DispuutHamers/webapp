class ApiKey < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail ignore: [:key]
  belongs_to :user
  has_many :api_logs, :foreign_key => 'key'
end
