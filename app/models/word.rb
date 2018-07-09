class Word < ApplicationRecord
  has_many :answers
  has_many :user_words
  belongs_to :lesson

  validates :name, presence: true, uniqueness: true
end
