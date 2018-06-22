class User < ApplicationRecord
  attr_accessor :remember_token, :remember_digest, :reset_token
  has_secure_password

  has_many :activities
  has_many :registers
  has_many :user_lessons
  has_many :user_words

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: Settings.user.validates.email_maximum },
            format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: Settings.user.validates.password_minimum },
            allow_blank: true
  validates :username,  presence: true, length: { maximum: Settings.user.validates.name_maximum }

  before_save :downcase_email
  before_save { self.email = email.downcase }

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end


  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
