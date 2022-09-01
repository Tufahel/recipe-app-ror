class Food < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods, dependent: :destroy

  has_many :recipes, through: :recipe_foods, dependent: :destroy

  validates :name, presence: true

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :measurement_unit, presence: true, uniqueness: { case_sensitive: false }
  
end
