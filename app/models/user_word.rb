class UserWord < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :answer

  before_save :check_correct

  scope :load_user_word, -> {select :id, :user_id, :word_id, :status}

  private

  def check_correct
    self.status = word.answers.correct.include? answer
  end
end

