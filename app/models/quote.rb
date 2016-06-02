class Quote < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :text, presence: true
  #validates :reporter, presence:true
		
	def as_json(options)
	  h = super({:only => [:id, :text, :user_id, :created_at]}.merge(options))
	end

end
