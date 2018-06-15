class User < ApplicationRecord
  has_many :activities
  has_many :registers
  has_many :user_lessons
  has_many :user_words
end
