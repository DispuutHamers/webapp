#The user model
class User < ActiveRecord::Base
  include UtilHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :lockable
  has_paper_trail :ignore => [:sunday_ratio, :encrypted_password, :reset_password_token, :reset_password_sent_at,
                              :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
                              :last_sign_in_ip, :password_salt, :confirmation_token, :confirmed_at, :confirmation_sent_at,
                              :remember_token, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at, :weight, :updated_at, :remember_token, :password_digest, :password, :password_confirmation]
  acts_as_paranoid :ignore => [:weight]
  before_save { self.email = email.downcase }
  has_many :groups, foreign_key: 'user_id'
  has_many :usergroups, through: :groups, foreign_key: 'group_id'
  has_many :quotes
  has_many :devices
  has_many :api_keys
  has_many :reviews
  has_many :motions
  has_many :events
  has_many :beers
  has_many :api_logs
  has_many :signups
  has_many :nicknames
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  #  default_scope { includes(:usergroups) }
  #
  scope :leden, -> { joins(:groups).where(groups: { group_id: 4 } ) }
  scope :aspiranten, -> { joins(:groups).where(groups: { group_id: 5 } ) }
  scope :oud, -> { joins(:groups).where(groups: { group_id: 12 } ) }

  def anonymize
    devices.destroy_all
    self.name = Faker::Name.name
    self.email = Faker::Internet.email(name) unless self.dev?
    save
  end

  def active_for_authentication?
    super #&& self.active?
  end

  def inactive_message
    "Je account heeft (nog) geen status in ons systeem, we kunnen je dus niet verder helpen."
  end

  def nickname
    nickname = ''
    nicknames.order('created_at DESC').each do |nick|
      nickname = nick.nickname + ' ' + nickname
    end

    nickname
  end

  def sign(event, status, reason)
    reason = UtilHelper.scramble_string(reason) if in_group?("Secretaris-generaal")
    if event.deadline > Time.now
      if event.attendance && !status
        return false if reason.length < 1
      end 
      id = event.id
      stemmen = signups.where(event_id: id)
      if stemmen.any?
        stemmen.last.update_attributes(status: status, reason: reason)
      else
        self.signups.create!(event_id: id, status: status, reason: reason)
      end
    end
  end

  def generate_api_key(name)
    ApiKey.new(user_id: self.id, name: name, key: SecureRandom.urlsafe_base64).save
  end

  def join_group(group)
    id = group.id
    if !groups.only_deleted.where(group_id: id).empty?
      groups.with_deleted.where(group_id: id).first.restore
    else
      groups.create!(group_id: id)
    end
  end

  def remove_group(group)
    groups.find_by(group_id: group.id).destroy!
  end

  def in_group?(name)
    self.usergroups.each do |group|
      return true if group.name == name.to_s
    end
    false
  end

  def lid?
    in_group?("Lid")
  end

  def alid?
    in_group?("A-Lid")
  end

  def olid?
    in_group?("O-Lid")
  end

  def active?
    lid? or olid? or alid?
  end

  def admin?
    in_group?("Triumviraat") || dev?
  end

  def dev?
    in_group?("Developer")
  end

  def brouwer?
    in_group?("Brouwer") || dev?
  end

  def lidstring
    return "lid" if lid?
    return "alid" if alid?
    return "olid" if olid?
    "none"
  end

  def as_json(options)
    json = super({ :only =>
                [:id, :name, :email, :created_at, :batch] }.merge(options))
    json[:reviews] = reviews.count
    json[:quotes] = quotes.count
    json[:sunday_ratio] = sunday_ratio
    json[:nicknames] = nicknames
    json[:usergroups] = usergroups
    json[:lid] = self.lidstring
    json[:admin] = admin? 

    json
  end
end
