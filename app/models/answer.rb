class Answer < ApplicationRecord
  belongs_to :word

  scope :correct, -> {where correctness: true}
end
