class User < ActiveRecord::Base
  include UtilHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable
  has_paper_trail ignore: %i[sunday_ratio encrypted_password reset_password_token reset_password_sent_at
remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip
last_sign_in_ip password_salt confirmation_token confirmed_at confirmation_sent_at
remember_token unconfirmed_email failed_attempts unlock_token locked_at weight updated_at remember_token password_digest password password_confirmation]
  acts_as_paranoid ignore: [:weight]
  before_save {self.email = email.downcase}
  has_many :groups, foreign_key: 'user_id'
  has_many :usergroups, through: :groups, foreign_key: 'group_id'
  has_many :quotes
  has_many :api_keys
  has_many :reviews
  has_many :events
  has_many :beers
  has_many :signups
  has_many :nicknames
  has_many :blogitems
  has_many :attendees
  has_many :meetings, through: :attendees
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }

  default_scope { includes(:groups, :usergroups) }

  scope :leden, -> { joins(:groups).where(groups: { group_id: 4 }) }
  scope :aspiranten, -> { joins(:groups).where(groups: { group_id: 5 }) }
  scope :oud, -> { joins(:groups).where(groups: { group_id: 12 }) }
  scope :extern, -> { where.not(id: Group.where(group_id: [4, 5, 12]).pluck(:user_id).uniq) }

  def anonymize
    self.name = Faker::Name.name
    self.email = Faker::Internet.email(name) unless dev?
    save
  end

  def active_for_authentication?
    super
  end

  def inactive_message
    'Je account heeft (nog) geen status in ons systeem, we kunnen je dus niet verder helpen.'
  end

  def nickname
    nickname = ''
    nicknames.order('created_at DESC').each do |nick|
      nickname = nick.nickname + ' ' + nickname
    end

    nickname
  end

  def signup(event, status, reason)
    return if event.deadline < Time.now
    return if event.attendance && status == "0" && reason.length < 6

    reason = UtilHelper.scramble_string(reason) if in_group?('Secretaris-generaal')
    signups.find_or_create_by(event_id: event.id).update_attributes(status: status, reason: reason)
    event
  end

  def generate_api_key(name)
    ApiKey.new(user_id: id, name: name, key: SecureRandom.urlsafe_base64).save
  end

  def join_group(group)
    if !groups.only_deleted.where(group_id: group.id).empty?
      groups.with_deleted.where(group_id: group.id).first.restore
    else
      groups.create!(group_id: group.id)
    end
  end

  def remove_group(group)
    groups.find_by(group_id: group.id).destroy!
  end

  def in_group?(name)
    usergroups.each do |group|
      return true if group.name == name.to_s
    end
    false
  end

  def lid?
    in_group?('Lid')
  end

  def alid?
    in_group?('A-Lid')
  end

  def olid?
    in_group?('O-Lid')
  end

  def active?
    lid? || olid? || alid?
  end

  def admin?
    in_group?('Triumviraat') || dev?
  end

  def dev?
    in_group?('Developer')
  end
end
