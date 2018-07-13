class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :registers

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :load_category, -> {select :id, :name, :description}
end
