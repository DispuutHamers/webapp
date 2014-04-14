class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_many :groups, foreign_key: "user_id", dependent: :destroy
  has_many :usergroups, through: :groups           
  has_many :quotes
  has_many :votes, dependent: :destroy
  has_many :signups, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, :presence => true, :confirmation => true, length: {minimum: 6}, :if => :password
  
  def feed  
    Quote.all
  end
  
  def vote!(poll, result)
    stemmen = votes.where(poll_id: poll.id, user_id: self.id)
    if stemmen.any?
      stemmen.each { |stem| stem.destroy! } 
    end
    self.votes.create!(poll_id: poll.id, result: result) 
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def in_group?(group)
    if !group
       return false
    end
    groups.find_by(group_id: group.id)
  end
  
  def join_group!(group)
    groups  .create!(group_id: group.id)
  end
  
  def remove_group!(group)
    groups.find_by(group_id: group.id).destroy!
  end
    
  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
