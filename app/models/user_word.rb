class UserWord < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :answer, optional: true

  before_save :check_correct

  scope :load_user_word, -> {select :id, :user_id, :word_id, :status}

  scope :by_word, -> lesson_id {
    joins(:word).where("lesson_id = ?", lesson_id)
  }

  scope :by_user, -> user_id { where(user_id: user_id) }
  private

  def check_correct
    self.status = word.answers.correct.include? answer
  end
end

