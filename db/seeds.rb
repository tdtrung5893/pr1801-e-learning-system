User.create!(username: "Admin", email: "example@railstutorial.org",
  password: "123456", password_confirmation: "123456", role: true)
User.create!(username: "Admin2", email: "example2@railstutorial.org",
  password: "123456", password_confirmation: "123456", role: true)
User.create!(username: "Tung", email: "nguyentung.pdu@gmail.com",
  password: "123456", password_confirmation: "123456")
Category.create!(name: "Basic")
Lesson.create!(name: "Giáo dục", category_id: 1)
Word.create!(name: "practice", question: "What does 'practice' mean?",
  lesson_id: 1)
Answer.create!(content: "luyện tập", word_id: 1, correctness: true)
Answer.create!(content: "kiểm tra", word_id: 1, correctness: false)
Word.create!(name: "idea", question: "What does 'idea' mean?", lesson_id: 1)
Answer.create!(content: "ý kiến", word_id: 2, correctness: true)
Answer.create!(content: "câu trả lời", word_id: 2, correctness: false)
Word.create!(name: "chapter", question: "What does 'chapter' mean?",
  lesson_id: 1)
Answer.create!(content: "chương", word_id: 3, correctness: true)
Answer.create!(content: "bài học", word_id: 3, correctness: false)
Word.create!(name: "word", question: "What does 'word' mean?", lesson_id: 1)
Answer.create!(content: "từ", word_id: 4, correctness: true)
Answer.create!(content: "âm thanh", word_id: 4, correctness: false)
Word.create!(name: "class", question: "What does 'class' mean?", lesson_id: 1)
Answer.create!(content: "buổi học", word_id: 5, correctness: true)
Answer.create!(content: "khóa học", word_id: 5, correctness: false)
Word.create!(name: "institute", question: "What does 'institute' mean?",
  lesson_id: 1)
Answer.create!(content: "học viện", word_id: 6, correctness: true)
Answer.create!(content: "thư viện", word_id: 6, correctness: false)
