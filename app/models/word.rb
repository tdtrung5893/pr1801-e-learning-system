class Word < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :user_words, dependent: :destroy
  belongs_to :lesson

  accepts_nested_attributes_for :user_words
  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :order_name_asc, -> { order name: :asc }
  scope :search_prefix, -> prefix { where "name like ?", "#{prefix}%" }
  scope :search_lesson, -> lesson_id {
    where(lesson_id: lesson_id) if lesson_id.present?}
  scope :search_learned, -> (learned, user_id) {
    if learned.present? && user_id.present?
      if learned == "1"
        joins(:user_words)
          .where("user_words.status = ? AND user_words.user_id = ?", learned,
            user_id)
      else
        left_outer_joins(:user_words)
          .where("(user_words.user_id = ? AND user_words.status = 0) OR user_words.status IS NULL",
            user_id)
      end
    end }
end
