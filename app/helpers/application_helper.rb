module ApplicationHelper
  def word_correct(lesson)
    word_correct = current_user.user_words.by_word(lesson). count { |item| item.status }
    total_word = lesson.words.size.to_f
    @percent_correct = (word_correct / total_word) * 100
  end

  def word_wrong(lesson)
    word_correct = current_user.user_words.by_word(lesson). count { |item| item.status }
    total_word = lesson.words.size.to_f
    @percent_wrong = ((total_word - word_correct) / total_word) * 100
  end
end
