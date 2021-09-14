class ApiKey < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  validates :user, presence: true
  validates :name, presence: true, allow_blank: false
  after_initialize :set_key

  def set_key
    self.key ||= SecureRandom.urlsafe_base64
  end
end
