#The user model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :lockable
  has_paper_trail :ignore => [:encrypted_password, :reset_password_token, :reset_password_sent_at,
        :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
        :last_sign_in_ip, :password_salt, :confirmation_token, :confirmed_at, :confirmation_sent_at,
        :remember_token, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at, :weight, :updated_at, :remember_token, :password_digest, :password, :password_confirmation]
  acts_as_paranoid :ignore => [:weight]
  before_save { self.email = email.downcase }
  attr_accessor :current_password
  has_many :groups, foreign_key: 'user_id', dependent: :destroy
  has_many :usergroups, through: :groups
  has_many :quotes
  has_many :devices
  has_many :api_keys
  has_many :reviews, :dependent => :destroy
  has_many :motions
  has_many :events
  has_many :beers, through: :reviews
  has_many :api_logs
  has_many :signups, dependent: :destroy
  has_many :nicknames, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  def active_for_authentication?
    super && self.active? 
  end

  def inactive_message
    "Sorry, this account has been deactivated."
  end

  def sunday_ratio 
    date = groups.where(group_id: 4).first.created_at
    drinks = Event.where(attendance: true).where("created_at > ?", date)
    t = 0.0
    s = 0.0
    drinks.each do |d|
      t = t + 1.0
      if !d.signups.where(user_id: id).blank?
        s = s + 1.0
      end
    end
    (s / t) * 100
  end

  def name_with_nickname
    name = read_attribute(:name)
    nicknames = self.nicknames.limit(3)
    if nicknames.count > 0
      name = self.nickname + '(' + name + ')'
    end
    name
  end

  def nickname
    nickname = ''
    nicknames.order('created_at DESC').each do |nick|
      nickname = nick.nickname + ' ' + nickname
    end
    nickname
  end

  def unreviewed_beers
    urev_beers = Beer.all
    beers.each do |beer|
      urev_beers = urev_beers - [beer]
    end
    urev_beers
  end

  def sign!(event, status, reason)
    if event.deadline > Time.now
      id = event.id
      stemmen = signups.where(event_id: id)
      if stemmen.any?
        stemmen.last.update_attributes(status: status, reason: reason)
      else
        self.signups.create!(event_id: id, status: status, reason: reason)
      end
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def generate_api_key(name)
    ApiKey.new(user_id: self.id, name: name, key: SecureRandom.urlsafe_base64).save
  end

  def in_group?(group)
    if group
      groups.find_by(group_id: group.id)
    end
  end

  def join_group!(group)
    id = group.id
    unless groups.only_deleted.where(group_id: id).empty?
      groups.with_deleted.where(group_id: id).first.restore
    else
      groups.create!(group_id: id)
    end
  end

  def remove_group!(group)
    groups.find_by(group_id: group.id).destroy!
  end

  def User.hash(token = nil)
    if token
      Digest::SHA1.hexdigest(token.to_s)
    else
      super()
    end
  end

  def lid?
    in_group?(Usergroup.find_by(name: 'lid'))
  end

  def alid?
    in_group?(Usergroup.find_by(name: 'A-Lid'))
  end

  def olid?
    in_group?(Usergroup.find_by(name: 'O-Lid'))
  end

  def active? 
    lid? or olid? or alid? 
  end

  def admin?
    in_group?(Usergroup.find_by(name: 'Triumviraat')) || dev? || schrijf_feut?
  end

  def dev?
    in_group?(Usergroup.find_by(name: 'Developer'))
  end

  def brouwer? 
    in_group?(Usergroup.find_by(name: "Brouwer"))
  end

  def update_weight
    cijfer = 0.0
    reviews = Review.where(user_id: self.id)
    reviews.each do |review|
      cijfer += review.rating
    end

    self.weight = (cijfer / reviews.count) unless reviews.empty?
    save
  end

  def schrijf_feut?
    in_group?(Usergroup.find_by(name: 'Secretaris-generaal'))
  end

  def as_json(options)
    h = super({ :only =>
               [:id, :name, :email, :created_at, :batch] }.merge(options))
    h[:reviews] = reviews.count
    h[:quotes] = quotes.count
    h[:nicknames] = nicknames(options)
    if alid?
      h[:lid] = 'alid'
    elsif olid?
      h[:lid] = 'olid'
    elsif lid?
      h[:lid] = 'lid'
    else
      h[:lid] = 'none'
    end

    admin? ? h[:admin] = true : h[:admin] = false

    h
  end

  private

  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end
end
