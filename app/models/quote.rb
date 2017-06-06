class Quote < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :text, presence: true
  #validates :reporter, presence:true
  acts_as_paranoid

  def self.default_scope
    where('deleted_at IS NULL')
  end

  def as_json(options)
    super({:only => [:id, :text, :user_id, :created_at]}.merge(options))
  end
end
