class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  scope :by_lesson, -> lesson_id { where(lesson_id: lesson_id) }
end
