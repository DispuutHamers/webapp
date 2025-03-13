class Quote < ActiveRecord::Base
  has_paper_trail skip: %i[text], unless: Proc.new { |q| q.anonymous? }
  acts_as_paranoid
  belongs_to :user, optional: true
  belongs_to :reporter, optional: true, class_name: "User"
  validates :text, presence: true
  serialize :text
  validate :reporter_and_user_differ

  has_encrypted :text

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RANDOM()') }
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

    destroy_versions!
  end

  private

  def reporter_and_user_differ
    return if anonymous?

    errors.add(:user, ": Je kan toch niet jezelf quoten!") if user_id == reporter_id
  end

  def destroy_versions!
    versions.destroy_all
  end
end
