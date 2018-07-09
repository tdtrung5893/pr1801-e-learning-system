class Lesson < ApplicationRecord
  has_many :words
  has_many :user_lessons
  belongs_to :category

  scope :load_lesson, -> {select :id, :name}
end
