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

  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: 'add_fields ' + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end
end
