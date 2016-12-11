class User < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  before_save { self.email = email.downcase }
  before_create :create_remember_token
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
  has_many :votes, dependent: :destroy
  has_many :signups, dependent: :destroy
  has_many :nicknames, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, :presence => true, :confirmation => true, length: {minimum: 6}, :if => :password

  def name_with_nickname
    name = read_attribute(:name)
    nicknames = self.nicknames
    if self.nicknames.count > 0
      name = self.nickname + '(' + name + ')'
    end

    name
  end

  def nickname
    nickname = ''
    nicknames.order('created_at DESC').each do |n|
      nickname = n.nickname + ' ' + nickname
    end

    nickname
  end

  def unreviewed_beers
    urev_beers = Beer.all
    beers.each do |b|
      urev_beers = urev_beers - [b]
    end

    urev_beers
  end

  def feed
    Quote.all.order('created_at DESC')
  end

  def vote!(poll, result)
    stemmen = votes.where(poll_id: poll.id, user_id: self.id)
    if stemmen.any?
      stemmen.each { |stem| stem.destroy! }
    end

    self.votes.create!(poll_id: poll.id, result: result)
  end

  def sign!(event, status)
    if event.deadline > Time.now
      stemmen = signups.where(event_id: event.id, user_id: self.id)
      if stemmen.any?
        stemmen.each { |stem| stem.destroy! }
      end

      self.signups.create!(event_id: event.id, status: status)
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def generate_api_key(name)
    ApiKey.new(user_id: self.id, name: name, key: SecureRandom.urlsafe_base64).save
  end

  def in_group?(group)
    groups.find_by(group_id: group.id)
  end

  def join_group!(group)
    unless groups.only_deleted.where(group_id: group.id).empty?
      groups.with_deleted.where(group_id: group.id).first.restore
    else
      groups.create!(group_id: group.id)
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

  def admin?
    in_group?(Usergroup.find_by(name: 'Triumviraat'))
  end

  def dev?
    in_group?(Usergroup.find_by(name: 'Developer'))
  end

  def update_weight
    cijfer = 0.0
    reviews = Review.where(user_id: self.id)
    reviews.each do |r|
      cijfer = cijfer + r.rating
    end

    self.weight = (cijfer / reviews.count) unless reviews.empty?
    self.save
  end

  def schrijf_feut?
    in_group?(Usergroup.find_by(name: 'Secretaris-generaal'))
  end

  def as_json(options)
    h = super({:only => [:id, :name, :email, :created_at, :batch]}.merge(options))
    h[:reviews] = reviews.count
    h[:quotes] = quotes.count
    h[:nicknames] = nicknames(options)
    if alid?
      h[:lid] = "alid"
    elsif olid?
      h[:lid] = "olid"
    elsif lid?
      h[:lid] = "lid"
    else
      h[:lid] = "none"
    end

    if admin?
      h[:admin] = 1
    else
      h[:admin] = 0
    end

    h
  end

  private

  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end
end
