class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text]
  acts_as_paranoid
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  validates :text, presence: true
  serialize :text
  validate :reporter_and_user_differ
  after_save :destroy_history

  encrypts :text

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }


  def anonymous?
    user.nil?
  end

  def destroy_history
    return unless anonymous?
    versions.destroy_all
  end

  def name
    return 'Anoniem' if anonymous?

    user.name
  end

  private

  def reporter_and_user_differ
    return if user_id.nil? || user_id != reporter_id

    errors.add(:user, ": Je kan toch niet jezelf quoten!")
  end
end
