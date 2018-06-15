class Lesson < ApplicationRecord
  has_many :words
  has_many :user_lessons
  belongs_to :category
end
