class AddIngredientsIdentifierToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :ingredients_identifier, :binary
  end
end
