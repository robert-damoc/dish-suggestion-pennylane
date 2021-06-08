class CreateIngredientsRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients_recipes do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.float :quantity
    end
  end
end
