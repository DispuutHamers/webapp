class News < ActiveRecord::Base

	def as_json(options)
		h = super({:only => [:id, :cat, :body, :title, :image, :date, :created_at]}.merge(options))
	end
end
