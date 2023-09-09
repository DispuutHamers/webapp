class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text]
  acts_as_paranoid
  belongs_to :user, optional: true
  belongs_to :reporter, optional: true, class_name: "User"
  validates :text, presence: true
  serialize :text
  validate :reporter_and_user_differ
  after_save :destroy_versions

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
    return false if anonymous?

    user.admin? || user.id == user_id
  end

  def name
    return 'Anoniem' if anonymous?

    user.name
  end

  def anonymize!
    self.user_id = nil
    self.reporter_id = nil
    self.save!
  end

  private

  def reporter_and_user_differ
    return if anonymous?

    errors.add(:user, ": Je kan toch niet jezelf quoten!") if user_id == reporter_id
  end

  def destroy_versions
    return unless anonymous?
    
    versions.destroy_all
  end
end
