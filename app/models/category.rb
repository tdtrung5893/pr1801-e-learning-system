class Category < ApplicationRecord
  has_many :lessons
  has_many :registers

  scope :load_category, -> {select :id, :name}
end
