class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_many :groups, foreign_key: 'user_id', dependent: :destroy
  has_many :usergroups, through: :groups
  has_many :quotes
  has_many :devices
  has_many :api_keys
  has_many :reviews
  has_many :motions
  has_many :events
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
    groups.create!(group_id: group.id)
  end

  def remove_group!(group)
    groups.find_by(group_id: group.id).destroy!
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def lid?
    in_group?(Usergroup.find_by(name: 'lid'))
  end

  def alid?
    in_group?(Usergroup.find_by(name: 'A-Lid'))
  end

  def admin?
    in_group?(Usergroup.find_by(name: 'Triumviraat')) || dev?
  end

  def dev?
    in_group?(Usergroup.find_by(name: 'Developer'))
  end

  def weight
    cijfer = 0.0
    reviews = Review.where(user_id: self.id)
    reviews.each do |r|
      cijfer = cijfer + r.rating
    end
    (cijfer / reviews.count)
  end

  def schrijf_feut?
    in_group?(Usergroup.find_by(name: 'Secretaris-generaal'))
  end

	def as_json(options)
	  h = super({:only => [:id, :name, :email, :created_at, :batch]}.merge(options))
		h[:reviews] = reviews.count
		h[:quotes] = quotes.count
		n = "[" 
		unless nicknames.empty?
			nicknames.each do |nick|
				n << "{\"nickname\":\"" + nick.nickname + "\"}," 
			end
			n[n.length - 1] = "]" 
		else 
			n << "]"
		end
		h[:nicknames] = n
		if lid? 
			h[:lid] = "lid"
		elsif alid?
			h[:lid] = "alid"
		else
			h[:lid] = "false"
		end
		h
	end

  private

  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end
end
