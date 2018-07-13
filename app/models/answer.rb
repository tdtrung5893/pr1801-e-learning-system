class Answer < ApplicationRecord
  belongs_to :word

  validates :content, presence: true

  scope :correct, -> {where correctness: true}
end
