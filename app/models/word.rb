class Word < ApplicationRecord
  has_many :user_words
  has_many :answers
  belongs_to :lesson
end
