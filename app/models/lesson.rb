class Lesson < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :user_lessons, dependent: :destroy
  belongs_to :category

  scope :load_lesson, -> {select :id, :name}
end
