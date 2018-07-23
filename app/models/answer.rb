class Answer < ApplicationRecord
  belongs_to :word
  has_many :user_words

  validates :content, presence: true

  scope :correct, -> {where correctness: true}
end
