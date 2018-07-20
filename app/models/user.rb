class User < ApplicationRecord
  attr_accessor :remember_token, :remember_digest, :reset_token
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  has_many :activities
  has_many :registers
  has_many :user_lessons
  has_many :user_words
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  validate :avatar_size
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: Settings.user.validates.email_maximum },
            format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: Settings.user.validates.password_minimum },
            allow_blank: true
  validates :username,  presence: true, length: { maximum: Settings.user.validates.name_maximum }

  scope :load_data, -> { select(:id, :avatar, :username, :email) }

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
    update_attributes remember_digest: User.digest(remember_token)
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

  def current_user? user
    self == user
  end

  def avatar_size
    if avatar.size > Settings.user.avatar_size.megabytes
      errors.add(:avatar, t(".avatar"))
    end
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end
end
