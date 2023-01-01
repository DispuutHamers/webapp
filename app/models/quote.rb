class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text]
  acts_as_paranoid
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  validates :text, presence: true
  # only if reporter exists, it should be a valid reporter
  validates :reporter, presence: true, if: :reporter_id
  validates :user, presence: true, if: :user_id
  serialize :text
  validate :reporter_and_user_differ
  validate :anonymous_user_and_reporter_nil

  encrypts :text

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }

  private

  def reporter_and_user_differ
    return unless reporter_id == user_id && !anonymous

    errors.add(:user, ": Je kan toch niet jezelf quoten!")
  end

  def anonymous_user_and_reporter_nil
    return unless anonymous && (user_id || reporter_id)

    errors.add(:user, ": Je kan toch niet jezelf quoten!")
  end
end
