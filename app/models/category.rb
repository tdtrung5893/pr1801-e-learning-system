class Category < ApplicationRecord
  has_many :lessons
  has_many :registers

  validates :name, presence: true, uniqueness: true

  scope :load_category, -> {select :id, :name, :description}
end
