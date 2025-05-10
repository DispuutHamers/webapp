class User < ActiveRecord::Base
  include UtilHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :two_factor_backupable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :two_factor_authenticatable,
         otp_secret_encryption_key: Rails.configuration.OTP_SECRET
  has_paper_trail ignore: %i[drink_ratio encrypted_password reset_password_token reset_password_sent_at
                             remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip
                             last_sign_in_ip password_salt confirmation_token confirmed_at confirmation_sent_at
                             remember_token unconfirmed_email failed_attempts unlock_token locked_at weight updated_at remember_token password_digest password password_confirmation
                             encrypted_otp_secret encrypted_otp_secret_iv encrypted_otp_secret_salt otp_backup_codes otp_secret consumed_timestep]
  acts_as_paranoid ignore: [:weight]
  serialize :otp_backup_codes, type: Array
  before_save { self.email = email.downcase }
  has_many :groups, foreign_key: 'user_id'
  has_many :usergroups, through: :groups, foreign_key: 'group_id'
  has_many :quotes
  has_many :api_keys
  has_many :reviews
  has_many :events
  has_many :beers
  has_many :signups
  has_many :guests, class_name: 'ExternalSignup', foreign_key: 'user_id'
  has_many :drafts
  has_many :blogitems
  has_many :attendees
  has_many :stickers
  has_many :chugs
  has_many :meetings_attended, through: :attendees, source: :meeting
  has_many :meetings_chaired, class_name: 'Meeting', inverse_of: :secretary, foreign_key: :chairman_id
  has_many :meetings_minuted, class_name: 'Meeting', inverse_of: :secretary, foreign_key: :secretary_id
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, format: Devise.email_regexp, uniqueness: { case_sensitive: false }

  scope :leden, -> { joins(:groups).where(groups: { group_id: 4 }) }
  scope :aspiranten, -> { joins(:groups).where(groups: { group_id: 5 }) }
  scope :oud, -> { joins(:groups).where(groups: { group_id: 12 }) }
  scope :extern, -> { where.not(id: Group.where(group_id: [4, 5, 12]).pluck(:user_id).uniq) }
  scope :intern, -> { where(id: Group.where(group_id: [4, 5, 12]).pluck(:user_id).uniq) }
  scope :leden_en_aspiranten, -> { where(id: Group.where(group_id: [4, 5]).pluck(:user_id).uniq) }

  def inactive_message
    'Je account heeft (nog) geen status in ons systeem, we kunnen je dus niet verder helpen.'
  end

  def signup(event, status, reason = '')
    return if event.deadline&.past?
    return if event.attendance && status == '0' && reason.length < 6

    reason = UtilHelper.scramble_string(reason) if in_group?('Secretaris-generaal')

    signups.find_or_create_by(event_id: event.id).update(status:, reason:)
    event
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
    usergroups.where(name:).exists?
  end

  def lid?
    # TODO: Refactor because this is not very useful
    in_group?('Lid') || in_group?('O-Lid')
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

  def traject?
    in_group?('Trajectcoördinatoren')
  end

  def lid_since
    groups.with_deleted.where(group_id: 4)&.first&.created_at || 'Pleb'
  end

  def can_view_quotes?
    otp_required_for_login? || Rails.env.development?
  end

  def average_review_grade
    weight&.round(2) || 'Nog onbekend'
  end

  def fastest_chug
    @chug = chugs.order('time ASC').first
    return '-' unless @chug

    "#{@chug.time.round(2)}s"
  end

  def next_birthday
    return unless birthday

    Rails.cache.fetch("next_birthday/#{id}", expires_in: 7.days) do
      y = Time.zone.today.year
      mmdd = birthday.strftime('%m%d')
      y += 1 if mmdd < Time.zone.today.strftime('%m%d')
      mmdd = '0301' if mmdd == '0229' && !Date.parse("#{y}0101").leap?

      "#{y}#{mmdd}"
    end
  end

  def birthday_ics
    return unless birthday

    ics = Icalendar::Event.new
    ics.dtstart = Icalendar::Values::Date.new(next_birthday)
    ics.summary = "#{name} jarig (#{birthday.strftime('%Y')})"

    ics
  end

  def to_s
    name
  end

  private

  ##
  # Decrypt and return the `encrypted_otp_secret` attribute which was used in
  # prior versions of devise-two-factor
  # @return [String] The decrypted OTP secret
  def legacy_otp_secret
    return nil unless self[:encrypted_otp_secret]
    return nil unless self.class.otp_secret_encryption_key

    hmac_iterations = 2000 # a default set by the Encryptor gem
    key = self.class.otp_secret_encryption_key
    salt = Base64.decode64(encrypted_otp_secret_salt)
    iv = Base64.decode64(encrypted_otp_secret_iv)

    raw_cipher_text = Base64.decode64(encrypted_otp_secret)
    # The last 16 bytes of the ciphertext are the authentication tag - we use
    # Galois Counter Mode which is an authenticated encryption mode
    cipher_text = raw_cipher_text[0..-17]
    auth_tag =  raw_cipher_text[-16..-1]

    # this algorithm lifted from
    # https://github.com/attr-encrypted/encryptor/blob/master/lib/encryptor.rb#L54

    # create an OpenSSL object which will decrypt the AES cipher with 256 bit
    # keys in Galois Counter Mode (GCM). See
    # https://ruby.github.io/openssl/OpenSSL/Cipher.html
    cipher = OpenSSL::Cipher.new('aes-256-gcm')

    # tell the cipher we want to decrypt. Symmetric algorithms use a very
    # similar process for encryption and decryption, hence the same object can
    # do both.
    cipher.decrypt

    # Use a Password-Based Key Derivation Function to generate the key actually
    # used for encryption from the key we got as input.
    cipher.key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(key, salt, hmac_iterations, cipher.key_len)

    # set the Initialization Vector (IV)
    cipher.iv = iv

    # The tag must be set after calling Cipher#decrypt, Cipher#key= and
    # Cipher#iv=, but before calling Cipher#final. After all decryption is
    # performed, the tag is verified automatically in the call to Cipher#final.
    #
    # If the auth_tag does not verify, then #final will raise OpenSSL::Cipher::CipherError
    cipher.auth_tag = auth_tag

    # auth_data must be set after auth_tag has been set when decrypting See
    # http://ruby-doc.org/stdlib-2.0.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html#method-i-auth_data-3D
    # we are not adding any authenticated data but OpenSSL docs say this should
    # still be called.
    cipher.auth_data = ''

    # #update is (somewhat confusingly named) the method which actually
    # performs the decryption on the given chunk of data. Our OTP secret is
    # short so we only need to call it once.
    #
    # It is very important that we call #final because:
    #
    # 1. The authentication tag is checked during the call to #final
    # 2. Block based cipher modes (e.g. CBC) work on fixed size chunks. We need
    #    to call #final to get it to process the last chunk properly. The output
    #    of #final should be appended to the decrypted value. This isn't
    #    required for streaming cipher modes but including it is a best practice
    #    so that your code will continue to function correctly even if you later
    #    change to a block cipher mode.
    cipher.update(cipher_text) + cipher.final
  end
end
