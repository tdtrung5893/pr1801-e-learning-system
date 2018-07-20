class UserWord < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :answer

  before_save :check_correct

  private

  def check_correct
    self.status = word.answers.correct.include? answer
  end
end

