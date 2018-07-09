class Category < ApplicationRecord
  has_many :lessons
  has_many :registers

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :load_category, -> {select :id, :name, :description}
end
