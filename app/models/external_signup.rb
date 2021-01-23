class ExternalSignup < ApplicationRecord
  attr_accessor :invitation_code
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true, length: {minimum: 2}
  validates :last_name, presence: true, length: {minimum: 2}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}

  belongs_to :event
end
