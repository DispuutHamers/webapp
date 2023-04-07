class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text]
  acts_as_paranoid
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  validates :text, presence: true
  serialize :text
  validate :reporter_and_user_differ
  validate :anonymous_user_and_reporter_nil

  after_save :delete_all_versions
  after_destroy :delete_all_versions

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
    return unless anonymous? && (user_id.present? || reporter_id.present?)

    errors.add(:user, ": Je kan toch niet jezelf quoten!")
  end

  def delete_all_versions
    if anonymous?
      versions.each do |version|
        version.destroy
      end
    end
  end
end
