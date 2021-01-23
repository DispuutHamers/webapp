class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text_ciphertext updated_at migrated_text]
  belongs_to :user
  validates :user_id, presence: true
  validates :text, presence: true
  acts_as_paranoid
  serialize :text

  encrypts :text, migrating: true

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }
end
