class User < ApplicationRecord
  has_many :activities
  has_many :registers
  has_many :user_lessons
  has_many :user_words

  attr_accessor :remember_token, :remember_digest
  has_secure_password
  before_save { self.email = email.downcase }
  validates :username,  presence: true, length: { maximum: Settings.user.validates.name_maximum }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: Settings.user.validates.email_maximum },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: Settings.user.validates.password_minimum } , allow_blank: true

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
end
