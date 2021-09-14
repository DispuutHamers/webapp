class ExternalSignup < ApplicationRecord
  attr_accessor :invitation_code
  belongs_to :event
  belongs_to :user, optional: true

  validates :first_name, presence: true, length: {minimum: 2}
  validates :last_name, presence: true, length: {minimum: 2}
  validates :email, presence: true, format: Devise.email_regexp
end
