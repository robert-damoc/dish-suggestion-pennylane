class Ingredient < ApplicationRecord
  has_and_belongs_to_many :recipes

  has_many :ingredients_recipes

  enum unit: {
    g: 0,
    piece: 1,
    cup: 2,
    tablespoons: 3,
    teaspoons: 4
  }
end
