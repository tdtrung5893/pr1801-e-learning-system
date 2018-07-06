class Category < ApplicationRecord
  has_many :lessons
  has_many :registers

  validates :name, presence: true

  scope :load_data_category, -> {select :id, :name, :description}
end
