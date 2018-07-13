class Word < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :user_words
  belongs_to :lesson

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :order_name_asc, -> {order name: :asc}
  scope :search_prefix, -> prefix {where "name like ?", "#{prefix}%"}

  accepts_nested_attributes_for :answers, allow_destroy: true
end
