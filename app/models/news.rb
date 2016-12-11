class News < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid

  def as_json(options)
    h = super({:only => [:id, :cat, :body, :title, :image, :date, :created_at]}.merge(options))
  end
end
