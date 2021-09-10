class ApiKey < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  after_initialize :set_key

  has_rich_text :actiontext_description

  scope :with_user, -> { includes(:user) }

  def set_key
    self.key ||= SecureRandom.urlsafe_base64
  end
end
