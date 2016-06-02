class Signup < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

	def as_json(options)
		h = super({:only => [:id, :user_id, :event_id, :status, :created_at]}.merge(options))
	end
end
