class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text]
  acts_as_paranoid
  belongs_to :user
  validates :user, presence: true
  validates :text, presence: true
  validate :ensure_reporter_user_exists
  serialize :text

  encrypts :text

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }

  def ensure_reporter_user_exists
    return unless self.reporter

    errors.add('Reporter') unless User.find_by_id(self.reporter)
  end
end
