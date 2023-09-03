class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text]
  acts_as_paranoid
  belongs_to :user, optional: true
  belongs_to :reporter, optional: true, class_name: "User"
  validates :text, presence: true
  serialize :text
  validate :reporter_and_user_differ
  after_save :destroy_versions if self.anonymous?

  encrypts :text

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }
  scope :anonymous, -> { where(user_id: nil) }
  scope :not_anonymous, -> { where.not(user_id: nil) }

  def anonymous?
    user.nil?
  end

  def can_be_anonymized_by?(user)
    !anonymous? && user.admin? || user.id == user_id
  end

  def name
    return 'Anoniem' if anonymous?

    user.name
  end

  private

  def reporter_and_user_differ
    return if anonymous? || user_id != reporter_id

    errors.add(:user, ": Je kan toch niet jezelf quoten!")
  end

  def destroy_versions
    versions.destroy_all
  end
end
